import JACC
JACC.@init_backend

function est_pi_jacc(N::Integer)
    halfpi = JACC.parallel_reduce(N; op = *, init=1.0) do n
        nf = Float64(n)
        return 4.0 * nf^2 / (4.0 * nf^2 - 1.0)
    end
    return 2.0 * halfpi
end

function est_pi_jacc_2(N::Integer)
    halfpi = JACC.parallel_reduce(JACC.launch_spec(), N; op = *, init=1.0) do n
        nf = Float64(n)
        return 4.0 * nf^2 / (4.0 * nf^2 - 1.0)
    end
    return 2.0 * Base.Array(halfpi)[]
end
