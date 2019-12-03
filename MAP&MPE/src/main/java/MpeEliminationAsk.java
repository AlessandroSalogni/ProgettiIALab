import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.proposition.AssignmentProposition;

import java.util.*;

public class MpeEliminationAsk implements BayesInference {
    private CategoricalDistribution mpeEliminationAsk(Factor factor, RandomVariable[] X) {
        List<Factor> factors = new ArrayList();
        factors.add(factor);

        for(RandomVariable var : X)
            factors = maxOut(var, factors);

        return (CategoricalDistribution) pointwiseProduct(factors);
    }

    public CategoricalDistribution ask(RandomVariable[] X, AssignmentProposition[] observedEvidence, BayesianNetwork bn) { return null; }

    public CategoricalDistribution ask(AssignmentProposition[] observedEvidence, BayesianNetwork bn) {
        List<RandomVariable> varWithoutEvidence = new ArrayList(bn.getVariablesInTopologicalOrder());
        for (AssignmentProposition ap : observedEvidence)
            varWithoutEvidence.removeAll(ap.getScope());

        Factor eliminationFactor = (Factor) new EliminationAsk().ask(varWithoutEvidence.toArray(new RandomVariable[varWithoutEvidence.size()]), observedEvidence, bn);
        return mpeEliminationAsk(eliminationFactor, varWithoutEvidence.toArray(new RandomVariable[varWithoutEvidence.size()]));
    }

    public CategoricalDistribution ask(Factor factor, RandomVariable[] X) {
        return mpeEliminationAsk(factor, X);
    }

    private List<Factor> maxOut(RandomVariable var, List<Factor> oldFactors) {
        List<Factor> newFactors = new ArrayList();
        List<Factor> factorToMultiply = new ArrayList();

        for(Factor factor : oldFactors)
            if (factor.contains(var))
                factorToMultiply.add(factor);
            else
                newFactors.add(factor);

        if(factorToMultiply.size() != 0)
            newFactors.add((this.pointwiseProduct(factorToMultiply)).maxOut(var));

        return newFactors;
    }

    private Factor pointwiseProduct(List<Factor> factors) {
        Factor product = factors.get(0);

        for(int i = 1; i < factors.size(); i++)
            product = product.pointwiseProduct(factors.get(i));

        return product;
    }
}
