# Positive direction means neighbour amongst top blocks
# Negative direction means neighbour amongst bottom blocks
# Transverse edges are not followed
# If the returned value is negative, then the neighbour corresponds to a
# transverse edge.
InterfaceNeighbour := function(parts, block_indices, direction, degree, p)
    local index, block_index, part;
    index := p;
    if direction < 0 then
        index := index + degree;
    fi;

    block_index := block_indices[index];
    part := parts[block_index];
    # Return the entry that isn't p
    if part[1] = p * direction then
        return part[2] * direction;
    else
        return part[1] * direction;
    fi;
end;

InterfaceComponents := function(x)
    local parts, block_indices, domain, interface, n, direction, not_yet_seen,
    component, p, start_points;
    parts := ExtRepOfObj(x);
    block_indices := IntRepOfBipartition(x);
    domain := DomainOfBipartition(x);
    n := DegreeOfBipartition(x);
    interface := [];
    not_yet_seen := [1 .. n];

    while not IsEmpty(not_yet_seen) do
        start_points := Intersection(not_yet_seen, domain);
        if not IsEmpty(start_points) then
            p := First(start_points);
        else
            p := First(not_yet_seen);
        fi;
        direction := 1;
        component := [];

        if p in domain then
            direction := -1;
        fi;

        while p in not_yet_seen do
            Add(component, p);
            Remove(not_yet_seen, Position(not_yet_seen, p));
            p := InterfaceNeighbour(parts, block_indices, direction, n, p);
            direction := direction * -1;
        od;

        # Complete the cycle
        if p > 0 then
            Add(component, p);
        fi;

        Add(interface, component);
    od;
    return interface;
end;

ComponentLength := x -> Length(x) - 1;

IsTwoPath := x -> ComponentLength(x) = 2 and First(x) <> Last(x);

# Takes a list of lists
IsCanonicalComponents := function(x)
    local n, two_paths, component;
    two_paths := Filtered(x, IsTwoPath);
    n := Size(two_paths);
    if n = 1 then
        return true;
    elif n = 0 or n > 3 then
        return false;
    fi;

    for component in two_paths do
        if [component[1] + 1, component[2] - 1, component[3] + 1] in two_paths
            then
            return false;
        fi;
    od;
    return true;
end;

TwoPathsOfComponents := x -> Filtered(x, IsTwoPath);

# IsCanonicalTwoPaths := function(x)
#     if Length(x) = 0 then
#         return false;
#     fi;

#     return not ContainsOverlappingComponents(x);
# end;

IsCanonicalBipartition := function(x)
    local components;
    components := InterfaceComponents(x);
    # two_paths := TwoPathsOfComponents(components);
    return IsCanonicalComponents(components);
end;
