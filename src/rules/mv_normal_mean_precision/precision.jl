@rule(
    form        => Type{ <: MvNormalMeanPrecision },
    on          => :Λ,
    vconstraint => Marginalisation,
    messages    => Nothing,
    marginals   => (q_out::Dirac, q_μ::MvNormalMeanPrecision),
    meta        => Nothing,
    begin
        (m_mean, v_mean) = mean(q_μ), cov(q_μ)
        (m_out, v_out)   = mean(q_out), cov(q_out)

        df = ndims(q_μ) + 2.0
        S  = cholinv(v_mean + v_out + (m_mean - m_out)*(m_mean - m_out)')

        return Wishart(df, S)
    end
)