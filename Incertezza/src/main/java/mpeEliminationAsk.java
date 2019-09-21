import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.proposition.AssignmentProposition;
import bifparser.BifBNReader;

public class mpeEliminationAsk implements BayesInference {
    public CategoricalDistribution ask(RandomVariable[] X, AssignmentProposition[] e, BayesianNetwork bn) {
        return null;
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
