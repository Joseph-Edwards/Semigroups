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
    component, p;
    parts := ExtRepOfObj(x);
    block_indices := IntRepOfBipartition(x);
    domain := DomainOfBipartition(x);
    n := DegreeOfBipartition(x);
    interface := [];
    not_yet_seen := [1 .. n];

    while not IsEmpty(not_yet_seen) do
        p := not_yet_seen[1];
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
