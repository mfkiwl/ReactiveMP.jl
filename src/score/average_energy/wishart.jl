
import StatsFuns: logπ

@average_energy(
    form      => Type{ <: Wishart },
    marginals => (q_out::Any, q_ν::Any, q_S::Any),
    meta      => Nothing,
    begin
        d = dim(q_out)

        m_q_ν   = mean(q_ν)
        m_q_S   = mean(q_S)
        m_q_out = mean(q_out)

        return 0.5 * (
            m_q_ν * (logdet(m_q_S) + d * log(2)) - 
            logdet(m_q_out) * (m_q_ν- d - 1.0) + 
            tr(cholinv(m_q_S) * m_q_out) + 0.5 * d * (d - 1) * logπ
        ) + mapreduce(i -> labsgamma(0.5 * (m_q_ν + 1.0 - i)), +, 1:d)
    end
)