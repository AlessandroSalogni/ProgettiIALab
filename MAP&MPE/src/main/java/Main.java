import aima.core.learning.framework.Example;
import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.bayes.impl.BayesNet;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.domain.ArbitraryTokenDomain;
import aima.core.probability.domain.BooleanDomain;
import aima.core.probability.example.BayesNetExampleFactory;
import aima.core.probability.example.ExampleRV;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.RandVar;
import bifparser.BifBNReader;

import java.util.Map;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
//        BayesianNetwork bn = null;
          long startTime, endTime, timeElapsed;
//
//        BifBNReader bnReader = null;
//        try {
//            bnReader = new BifBNReader("1_insurance.bif") {
//                @Override
//                protected Node nodeCreation(RandomVariable var, double[] probs, Node... parents) {
//                    return new FullCPTNode(var, probs, parents);
//                }
//            };
//            bn = bnReader.getBayesianNetwork();
//        } catch (Exception e1) {
//            e1.printStackTrace();
//        }

        //Earthquake
        //BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        //RandomVariable[] mapVar = {ExampleRV.EARTHQUAKE_RV, ExampleRV.ALARM_RV, ExampleRV.BURGLARY_RV};
        //AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.JOHN_CALLS_RV, false)};

        //Insurance
//        RandomVariable[] mapVar = {new RandVar("GOODSTUDENT",  new ArbitraryTokenDomain("True", "False"))};
//        AssignmentProposition[] e = {new AssignmentProposition(new RandVar("AGE", new ArbitraryTokenDomain("Adolescent", "Adult", "Senior")), "Adolescent")};

        //Diabetes
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Pigs
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Munif
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

//        startTime = System.nanoTime();
//
//        CategoricalDistribution resMap = new MapEliminationAsk().ask(mapVar, e, bn);
//        System.out.println("MAP Probability: " +  resMap.getValues()[0]);
//        for(Map.Entry<RandomVariable,Object> varValue : resMap.getBestVarsValues()[0].entrySet())
//            System.out.println(varValue.getKey() + " -> " + varValue.getValue());
//
//        endTime = System.nanoTime();
//        timeElapsed = endTime - startTime;
//        System.out.println("MAP - Execution time in milliseconds: " + timeElapsed / 1000000 + "\n\n");
//
//        startTime = System.nanoTime();
//
//        CategoricalDistribution resMpe = new MpeEliminationAsk().ask(null, e, bn);
//        System.out.println("MPE Probability: " +  resMpe.getValues()[0]);
//        for(Map.Entry<RandomVariable,Object> varValue : resMpe.getBestVarsValues()[0].entrySet())
//            System.out.println(varValue.getKey() + " -> " + varValue.getValue());
//
//        endTime = System.nanoTime();
//        timeElapsed = endTime - startTime;
//        System.out.println("MPE - Execution time in milliseconds: " + timeElapsed / 1000000);

        Scanner myObj = new Scanner(System.in);
        System.out.println("Enter a number of node of a polytree");

        int numberOfNode = Integer.parseInt(myObj.nextLine());

        RandVar[] X = new RandVar[numberOfNode];
        for(int i=0; i < numberOfNode; i++)
            X[i] = new RandVar("X"+i, new BooleanDomain());

        FiniteNode startNode = new FullCPTNode(X[0], new double[]{0.8D, 0.2D});
        FiniteNode prevNode = new FullCPTNode(X[1], new double[]{0.99D, 0.01D, 0.4D, 0.6D}, new Node[]{startNode});

        for(int i=2; i < numberOfNode; i++)
            prevNode = new FullCPTNode(X[i], new double[]{0.99D, 0.01D, 0.4D, 0.6D}, new Node[]{prevNode});

        BayesNet polytree = new BayesNet(new Node[]{startNode});

        startTime = System.nanoTime();

        CategoricalDistribution resMpePolytree = new MpeEliminationAsk().ask(new AssignmentProposition[]{new AssignmentProposition(X[numberOfNode-1], true)}, polytree);

        endTime = System.nanoTime();

        System.out.println("MPE Probability: " +  resMpePolytree.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMpePolytree.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        timeElapsed = (endTime - startTime)/1000000;
        System.out.println("MPE polytree - Execution time in milliseconds: " + timeElapsed);

        startTime = System.nanoTime();

        int mapVarsDim = 4;
        RandVar[] mapVars = new RandVar[mapVarsDim];
        System.arraycopy(X, 0, mapVars, 0, mapVarsDim);

        CategoricalDistribution resMapPolytree = new MapEliminationAsk().ask(mapVars, new AssignmentProposition[]{new AssignmentProposition(X[numberOfNode-1], true)}, polytree);

        endTime = System.nanoTime();

        System.out.println("MAP Probability: " +  resMapPolytree.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMapPolytree.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        timeElapsed = endTime - startTime;
        System.out.println("MAP polytree - Execution time in milliseconds: " + timeElapsed / 1000000);
    }
}
