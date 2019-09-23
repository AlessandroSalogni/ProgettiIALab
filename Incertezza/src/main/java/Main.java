import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.example.BayesNetExampleFactory;
import aima.core.probability.example.ExampleRV;
import aima.core.probability.proposition.AssignmentProposition;

public class Main {
    public static void main(String[] args) {
        BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        RandomVariable[] var = {ExampleRV.ALARM_RV};
        AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.JOHN_CALLS_RV, true)};

        new EliminationAsk().ask(var, e, bn);

//        BifBNReader bnReader = new BifBNReader("earthquake.bif") {
//            @Override
//            protected Node nodeCreation(RandomVariable var, double[] probs, Node... parents) {
//                return new FullCPTNode(var, probs, parents);
//            }
//        };
//
//        BayesianNetwork bn = bnReader.getBayesianNetwork();
    }
}
