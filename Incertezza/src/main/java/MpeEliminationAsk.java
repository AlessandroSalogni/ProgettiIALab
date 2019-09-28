import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.Node;
import aima.core.probability.proposition.AssignmentProposition;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class MpeEliminationAsk implements BayesInference {

    public CategoricalDistribution mpeEliminationAsk(AssignmentProposition[] e, BayesianNetwork bn) {
        List<RandomVariable> topologicOrderVar = new ArrayList();
        topologicOrderVar.addAll(bn.getVariablesInTopologicalOrder());
        List<RandomVariable> reverseTopologicOrderVar = reverseOrder(topologicOrderVar);

        List<Factor> factors = new ArrayList();
        for(RandomVariable var : reverseTopologicOrderVar) {
            factors.add(makeFactor(var, e, bn));
            factors = this.maxOut(var, (List)factors);
        }

        return (CategoricalDistribution) factors.get(0);//TODO controllare indice
    }

    public CategoricalDistribution ask(RandomVariable[] X, AssignmentProposition[] observedEvidence, BayesianNetwork bn) {
        return mpeEliminationAsk(observedEvidence, bn);
    }

    protected List<RandomVariable> reverseOrder(Collection<RandomVariable> vars) {
        List<RandomVariable> order = new ArrayList(vars);
        Collections.reverse(order);
        return order;
    }

    private Factor makeFactor(RandomVariable var, AssignmentProposition[] e, BayesianNetwork bn) {
        Node n = bn.getNode(var);
        if (!(n instanceof FiniteNode)) {
            throw new IllegalArgumentException("Elimination-Ask only works with finite Nodes.");
        } else {
            FiniteNode fn = (FiniteNode)n;
            List<AssignmentProposition> evidence = new ArrayList();

            for(int i = 0; i < e.length; i++) {
                AssignmentProposition ap = e[i];
                if (fn.getCPT().contains(ap.getTermVariable())) {
                    evidence.add(ap);
                }
            }

            return fn.getCPT().getFactorFor((AssignmentProposition[])evidence.toArray(new AssignmentProposition[evidence.size()]));
        }
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
