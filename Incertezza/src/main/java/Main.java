import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.example.BayesNetExampleFactory;
import aima.core.probability.example.ExampleRV;
import aima.core.probability.proposition.AssignmentProposition;

import java.util.Map;

public class Main {
    public static void main(String[] args) {
        BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        RandomVariable[] var = {ExampleRV.ALARM_RV};
        AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.BURGLARY_RV, false),
                new AssignmentProposition(ExampleRV.EARTHQUAKE_RV, true),
                new AssignmentProposition(ExampleRV.MARY_CALLS_RV, true)};

        CategoricalDistribution res = new MpeEliminationAsk().ask(var, e, bn);

        System.out.println("Probability: " +  res.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : res.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());


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
