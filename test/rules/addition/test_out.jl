module RulesAdditionOutTest

using Test
using ReactiveMP
using Random

import ReactiveMP: @test_rules

@testset "rules:typeof(+):out" begin

     @testset "Belief Propagation: (m_in1::PointMass, m_in2::PointMass)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = PointMass(1.0),                    m_in2 = PointMass(1.0)),                     output = PointMass(2.0)),
            (input = (m_in1 = PointMass([ 2.0 ]),                m_in2 = PointMass([ -2.0 ])),                output = PointMass([ 0.0 ])),
            (input = (m_in1 = PointMass([ 1.0 2.0; 3.0 4.0 ]),  m_in2 = PointMass([-2.0 -1.0; -4.0 -3.0])), output = PointMass([ -1.0 1.0; -1.0 1.0 ])),
        ]

    end

    @testset "Belief Propagation: (m_in1::UnivariateNormalDistributionsFamily, m_in2::PointMass)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = NormalMeanVariance(1.0, 2.0),   m_in2 = PointMass(1.0)),  output = NormalMeanVariance(2.0, 2.0)),
            (input = (m_in1 = NormalMeanVariance(-1.0, 3.0),  m_in2 = PointMass(-3.0)), output = NormalMeanVariance(-4.0, 3.0)),
            (input = (m_in1 = NormalMeanPrecision(4.0, 7.0),  m_in2 = PointMass(1.0)),  output = NormalMeanPrecision(5.0, 7.0)),
            (input = (m_in1 = NormalMeanPrecision(-1.0, 2.0), m_in2 = PointMass(-3.0)), output = NormalMeanPrecision(-4.0, 2.0)),
            (input = (m_in1 = NormalWeightedMeanPrecision(4.0, 2.0), m_in2 = PointMass(1.0)),  output = NormalMeanVariance(3.0, 1/2)),
            (input = (m_in1 = NormalWeightedMeanPrecision(8.0, 4.0), m_in2 = PointMass(-3.0)), output = NormalMeanVariance(-1.0, 1/4)),
        ]

    end

    @testset "Belief Propagation: (m_in1::PointMass, m_in2::UnivariateNormalDistributionsFamily)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = PointMass(1.0),  m_in2 = NormalMeanVariance(1.0, 2.0)),  output = NormalMeanVariance(2.0, 2.0)),
            (input = (m_in1 = PointMass(-3.0), m_in2 = NormalMeanVariance(-1.0, 3.0)), output = NormalMeanVariance(-4.0, 3.0)),
            (input = (m_in1 = PointMass(1.0),  m_in2 = NormalMeanPrecision(4.0, 7.0)),  output = NormalMeanPrecision(5.0, 7.0)),
            (input = (m_in1 = PointMass(-3.0), m_in2 = NormalMeanPrecision(-1.0, 2.0)), output = NormalMeanPrecision(-4.0, 2.0)),
            (input = (m_in1 = PointMass(1.0),  m_in2 = NormalWeightedMeanPrecision(4.0, 2.0)),  output = NormalMeanVariance(3.0, 1/2)),
            (input = (m_in1 = PointMass(-3.0), m_in2 = NormalWeightedMeanPrecision(8.0, 4.0)), output = NormalMeanVariance(-1.0, 1/4)),
        ]

    end

    @testset "Belief Propagation: (m_in1::MultivariateNormalDistributionsFamily, m_in2::PointMass)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = MvNormalMeanCovariance([1.0, 3.0], [3.0 2.0; 2.0 4.0]),  m_in2 = PointMass([1.0, 1.0])),  output = MvNormalMeanCovariance([2.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = MvNormalMeanCovariance([-4.0, 3.0], [3.0 2.0; 2.0 4.0]), m_in2 = PointMass([1.0, 1.0])),  output = MvNormalMeanCovariance([-3.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = MvNormalMeanPrecision([-4.0, 3.0], [3.0 2.0; 2.0 4.0]),  m_in2 = PointMass([1.0, 1.0])),  output = MvNormalMeanPrecision([-3.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = MvNormalMeanPrecision([-4.0, 3.0], [3.0 2.0; 2.0 4.0]),  m_in2 = PointMass([-2.0, 1.0])), output = MvNormalMeanPrecision([-6.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = MvNormalWeightedMeanPrecision([1.0, 3.0], [ 1.0 0.0; 0.0 1.0 ]), m_in2 = PointMass([ 2.0, 7.0 ])),  output = MvNormalMeanCovariance([ 3.0, 10.0 ], [ 1.0 0.0; 0.0 1.0 ])),
            (input = (m_in1 = MvNormalWeightedMeanPrecision([2.0, 4.0], [ 2.0 0.0; 0.0 2.0 ]), m_in2 = PointMass([ 1.0, 3.0 ])),  output = MvNormalMeanCovariance([ 2.0, 5.0 ], [ 1/2 0.0; 0.0 1/2 ])),
        ]

    end

    @testset "Belief Propagation: (m_in1::PointMass, m_in2::MultivariateNormalDistributionsFamily)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = PointMass([1.0, 1.0]),  m_in2 = MvNormalMeanCovariance([1.0, 3.0], [3.0 2.0; 2.0 4.0])),  output = MvNormalMeanCovariance([2.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = PointMass([1.0, 1.0]), m_in2 = MvNormalMeanCovariance([-4.0, 3.0], [3.0 2.0; 2.0 4.0])),  output = MvNormalMeanCovariance([-3.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = PointMass([1.0, 1.0]),  m_in2 = MvNormalMeanPrecision([-4.0, 3.0], [3.0 2.0; 2.0 4.0])),  output = MvNormalMeanPrecision([-3.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = PointMass([-2.0, 1.0]),  m_in2 = MvNormalMeanPrecision([-4.0, 3.0], [3.0 2.0; 2.0 4.0])), output = MvNormalMeanPrecision([-6.0, 4.0], [3.0 2.0; 2.0 4.0])),
            (input = (m_in1 = PointMass([ 2.0, 7.0 ]), m_in2 = MvNormalWeightedMeanPrecision([1.0, 3.0], [ 1.0 0.0; 0.0 1.0 ])),  output = MvNormalMeanCovariance([ 3.0, 10.0 ], [ 1.0 0.0; 0.0 1.0 ])),
            (input = (m_in1 = PointMass([ 1.0, 3.0 ]), m_in2 = MvNormalWeightedMeanPrecision([2.0, 4.0], [ 2.0 0.0; 0.0 2.0 ])),  output = MvNormalMeanCovariance([ 2.0, 5.0 ], [ 1/2 0.0; 0.0 1/2 ])),
        ]

    end

    @testset "Belief Propagation: (m_in1::UnivariateNormalDistributionsFamily, m_in2::UnivariateNormalDistributionsFamily)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = NormalMeanVariance(1.0, 2.0),   m_in2 = NormalMeanVariance(3.0, 4.0)),    output = NormalMeanVariance(4.0, 6.0)),
            (input = (m_in1 = NormalMeanVariance(-1.0, 2.0),  m_in2 = NormalMeanVariance(-2.0, 3.0)),   output = NormalMeanVariance(-3.0, 5.0)),
            (input = (m_in1 = NormalMeanPrecision(2.0, 2.0),  m_in2 = NormalMeanPrecision(-1.0, 3.0)),  output = NormalMeanVariance(1.0, (2.0 + 3.0) / (2.0*3.0))),
            (input = (m_in1 = NormalMeanPrecision(-1.0, 2.0), m_in2 = NormalMeanPrecision(-1.0, 3.0)),  output = NormalMeanVariance(-2.0, (2.0 + 3.0) / (2.0*3.0))),
            (input = (m_in1 = NormalMeanPrecision(2.0, 2.0),  m_in2 = NormalMeanVariance(-1.0, 3.0)),   output = NormalMeanVariance(1.0, 3.5)),
            (input = (m_in1 = NormalWeightedMeanPrecision(8.0, 4.0), m_in2 = NormalMeanVariance(-3.0, 1.0)), output = NormalMeanVariance(-1.0, 5/4)),
            (input = (m_in1 = NormalMeanVariance(-4.0, 2.0), m_in2 = NormalWeightedMeanPrecision(6.0, 3.0)), output = NormalMeanVariance(-2.0, 7/3)),
        ]

    end

    @testset "Belief Propagation: (m_in1::MultivariateNormalDistributionsFamily, m_in2::MultivariateNormalDistributionsFamily)" begin

        @test_rules [ with_float_conversions = true ] typeof(+)(:out, Marginalisation) [
            (input = (m_in1 = MvNormalMeanCovariance([1.0, 3.0], [3.0 2.0; 2.0 4.0]),  m_in2 = MvNormalMeanCovariance([1.0, 3.0], [3.0 2.0; 2.0 4.0])), output = MvNormalMeanCovariance([2.0, 6.0], [6.0 4.0; 4.0 8.0])),
            (input = (m_in1 = MvNormalMeanCovariance([-1.0, 3.0], [3.0 2.0; 2.0 4.0]),  m_in2 = MvNormalMeanCovariance([0.0, 3.0], [3.0 2.0; 2.0 4.0])), output = MvNormalMeanCovariance([-1.0, 6.0], [6.0 4.0; 4.0 8.0])),
            (input = (m_in1 = MvNormalMeanPrecision([1.0, 0.0], [2.0 0.0; 0.0 1.0]), m_in2 = MvNormalMeanPrecision([1.0, -7.0], [2.0 0.0; 0.0 3.0])), output = MvNormalMeanCovariance([2.0, -7.0], [1.0 0.0; 0.0 4/3])),
            (input = (m_in1 = MvNormalMeanCovariance([1.0, -1.0], [3.0 1.0; 1.0 4.0]), m_in2 = MvNormalMeanPrecision([1.0, 4.0], [2.0 1.0; 1.0 3.0])), output = MvNormalMeanCovariance([2.0, 3.0], [36/10 4/5; 4/5 44/10])),
            (input = (m_in1 = MvNormalMeanPrecision([1.0, 0.0], [2.0 0.0; 0.0 1.0]), m_in2 = MvNormalWeightedMeanPrecision([1.0, -7.0], [2.0 0.0; 0.0 3.0])), output = MvNormalMeanCovariance([3/2, -7/3], [1.0 0.0; 0.0 4/3])),
            (input = (m_in1 = MvNormalMeanCovariance([1.0, -1.0], [3.0 1.0; 1.0 4.0]), m_in2 = MvNormalWeightedMeanPrecision([1.0, 4.0], [2.0 1.0; 1.0 3.0])), output = MvNormalMeanCovariance([4/5, 2/5], [36/10 4/5; 4/5 44/10])),
            (input = (m_in1 = MvNormalWeightedMeanPrecision([1.0, -7.0], [2.0 0.0; 0.0 3.0]), m_in2 = MvNormalMeanPrecision([1.0, 0.0], [2.0 0.0; 0.0 1.0])), output = MvNormalMeanCovariance([3/2, -7/3], [1.0 0.0; 0.0 4/3])),
            (input = (m_in1 = MvNormalWeightedMeanPrecision([1.0, 4.0], [2.0 1.0; 1.0 3.0]), m_in2 = MvNormalMeanCovariance([1.0, -1.0], [3.0 1.0; 1.0 4.0])), output = MvNormalMeanCovariance([4/5, 2/5], [36/10 4/5; 4/5 44/10])),
        ]

    end
end
end