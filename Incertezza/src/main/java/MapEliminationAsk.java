import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.proposition.AssignmentProposition;

public class MapEliminationAsk implements BayesInference {
    @Override
    public CategoricalDistribution ask(RandomVariable[] mapVar, AssignmentProposition[] e, BayesianNetwork bn) {
        Factor eliminationFactor = (Factor) new EliminationAsk().ask(mapVar, e, bn);
        return new MpeEliminationAsk().ask(eliminationFactor, mapVar, bn);
    }
}
