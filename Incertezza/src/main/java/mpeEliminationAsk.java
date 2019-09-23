import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.ProbabilityTable;
import bifparser.BifBNReader;

import java.util.*;

public class mpeEliminationAsk implements BayesInference {

    public CategoricalDistribution mpeEliminationAsk(AssignmentProposition[] e, BayesianNetwork bn) {
        List<RandomVariable> topologicOrderVar = new ArrayList();
        topologicOrderVar.addAll(bn.getVariablesInTopologicalOrder());
        reverseOrder(topologicOrderVar);

        List<Factor> factors = new ArrayList();

        for(RandomVariable var : topologicOrderVar) {
            factors.add(0, this.makeFactor(var, e, bn));
        }

        while(topologicOrderVar.hasNext()) {
            if (hidden.contains(var)) {
                factors = this.sumOut(var, (List)factors, bn);
            }
        }

        Factor product = this.pointwiseProduct((List)factors);
        return ((ProbabilityTable)product.pointwiseProductPOS(_identity, X)).normalize();
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

    /*USO del parser

    public static void main(String[] args) throws Exception {
        BifBNReader bnReader = new BifBNReader("earthquake.bif") {
            @Override
            protected Node nodeCreation(RandomVariable var, double[] probs, Node... parents) {
                return new FullCPTNode(var, probs, parents);
            }
        };

        BayesianNetwork bn = bnReader.getBayesianNetwork();
    }
    */
}
