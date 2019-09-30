import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.proposition.AssignmentProposition;

import java.util.ArrayList;
import java.util.List;

public class MapEliminationAsk implements BayesInference {
    @Override
    public CategoricalDistribution ask(RandomVariable[] X, AssignmentProposition[] e, BayesianNetwork bn) {
        List<RandomVariable> mapVar = new ArrayList<>(bn.getVariablesInTopologicalOrder());

        for(RandomVariable rv : X)
            mapVar.remove(rv);
        for (AssignmentProposition ap : e)
            mapVar.removeAll(ap.getScope());

        Factor factor = (Factor) new EliminationAsk().ask((RandomVariable[]) mapVar.toArray(), e, bn);
        return null;
    }
}
