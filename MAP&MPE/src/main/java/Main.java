import aima.core.learning.framework.Example;
import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.domain.ArbitraryTokenDomain;
import aima.core.probability.domain.BooleanDomain;
import aima.core.probability.example.BayesNetExampleFactory;
import aima.core.probability.example.ExampleRV;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.RandVar;
import bifparser.BifBNReader;

import java.util.Map;

public class Main {
    public static void main(String[] args) {
        BayesianNetwork bn = null;
        long startTime, endTime, timeElapsed;

        BifBNReader bnReader = null;
        try {
            bnReader = new BifBNReader("1_insurance.bif") {
                @Override
                protected Node nodeCreation(RandomVariable var, double[] probs, Node... parents) {
                    return new FullCPTNode(var, probs, parents);
                }
            };
            bn = bnReader.getBayesianNetwork();
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        //Earthquake
        //BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        //RandomVariable[] mapVar = {ExampleRV.EARTHQUAKE_RV, ExampleRV.ALARM_RV, ExampleRV.BURGLARY_RV};
        //AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.JOHN_CALLS_RV, false)};

        //Insurance
        RandomVariable[] mapVar = {new RandVar("GOODSTUDENT",  new ArbitraryTokenDomain("True", "False"))};
        AssignmentProposition[] e = {new AssignmentProposition(new RandVar("AGE", new ArbitraryTokenDomain("Adolescent", "Adult", "Senior")), "Adolescent")};

        //Diabetes
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Pigs
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Munif
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        startTime = System.nanoTime();

        CategoricalDistribution resMap = new MapEliminationAsk().ask(mapVar, e, bn);

        System.out.println("MAP Probability: " +  resMap.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMap.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        endTime = System.nanoTime();

        timeElapsed = endTime - startTime;

        System.out.println("Execution time in nanoseconds: " + timeElapsed);
        System.out.println("Execution time in milliseconds: " + timeElapsed / 1000000 + "\n\n");

        startTime = System.nanoTime();
        CategoricalDistribution resMpe = new MpeEliminationAsk().ask(null, e, bn);

        System.out.println("MPE Probability: " +  resMpe.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMpe.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        endTime = System.nanoTime();

        timeElapsed = endTime - startTime;

        System.out.println("Execution time in nanoseconds: " + timeElapsed);
        System.out.println("Execution time in milliseconds: " + timeElapsed / 1000000);

    }
}
