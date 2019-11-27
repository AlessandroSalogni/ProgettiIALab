import aima.core.learning.framework.Example;
import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.example.BayesNetExampleFactory;
import aima.core.probability.example.ExampleRV;
import aima.core.probability.proposition.AssignmentProposition;

import java.util.Map;

public class Main {
    public static void main(String[] args) {
        BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        RandomVariable[] mapVar = {ExampleRV.EARTHQUAKE_RV, ExampleRV.ALARM_RV, ExampleRV.BURGLARY_RV};
        AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.JOHN_CALLS_RV, false)};

        CategoricalDistribution res = new MapEliminationAsk().ask(mapVar, e, bn);

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
