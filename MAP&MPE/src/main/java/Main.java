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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        //Earthquake
        //BayesianNetwork bn = BayesNetExampleFactory.constructBurglaryAlarmNetwork();
        //RandomVariable[] mapVar = {ExampleRV.EARTHQUAKE_RV, ExampleRV.ALARM_RV, ExampleRV.BURGLARY_RV};
        //AssignmentProposition[] e = {new AssignmentProposition(ExampleRV.JOHN_CALLS_RV, false)};

        BayesianNetwork bn = null;

        BifBNReader bnReader;
        try {
            bnReader = new BifBNReader("child.bif") {
                @Override
                protected Node nodeCreation(RandomVariable var, double[] probs, Node... parents) {
                    return new FullCPTNode(var, probs, parents);
                }
            };
            bn = bnReader.getBayesianNetwork();



//            List<RandomVariable> subVars = new ArrayList<>(vars.subList(0,1));
//            AssignmentProposition[] e = {
//                new AssignmentProposition(vars.get(4), "True")
//            };
//
//            RandomVariable[] mapVar = subVars.toArray(new RandomVariable[subVars.size()]);
//            RandomVariable[] mpeVar = vars.toArray(new RandomVariable[subVars.size()]);

            List<RandomVariable> vars = bn.getVariablesInTopologicalOrder();
            List<RandomVariable> subVars = new ArrayList<>(vars);

//            AssignmentProposition[] e = {
//                new AssignmentProposition(vars.get(12), "True"),
//                new AssignmentProposition(vars.get(0), "Domino"),
//                new AssignmentProposition(vars.get(16), "Poor")
//            };

//            AssignmentProposition[] e = {
//                    new AssignmentProposition(vars.get(12), "True"),
//                    new AssignmentProposition(vars.get(0), "Domino"),
//                    new AssignmentProposition(vars.get(16), "Poor")
//                    new AssignmentProposition(vars.get(26), "Million")
//            };
            AssignmentProposition[] e = {
//                    new AssignmentProposition(vars.get(12), "True"),
//                    new AssignmentProposition(vars.get(0), "Domino")
            };
            RandomVariable[] mapVar = subVars.toArray(new RandomVariable[subVars.size()]);
            RandomVariable[] mpeVar = vars.toArray(new RandomVariable[subVars.size()]);

            runMAP(mapVar, e, bn);
            runMPE(mpeVar, e, bn);


//            for(RandomVariable var : vars){
//                if(var.getDomain().size() >= 3)
//                    subVarsPrev.add(var);
//            }

        // subVars.addAll(subVarsNext);

        //RandomVariable[] mapVar = subVars.toArray(new RandomVariable[subVars.size()]);

//        AssignmentProposition[] e = {
//                new AssignmentProposition(vars.get(19), "Poor"),
//                new AssignmentProposition(vars.get(20), "Mild"),
//                new AssignmentProposition(vars.get(21), "Severe"),
//                new AssignmentProposition(vars.get(22), "Million"),
//                new AssignmentProposition(vars.get(23), "Million"),
//                new AssignmentProposition(vars.get(24), "Million"),
//                new AssignmentProposition(vars.get(25), "Million"),
//                new AssignmentProposition(vars.get(26), "Million"),
//        };

//        AssignmentProposition[] e = {
//                new AssignmentProposition(vars.get(0), "Domino"),
//                new AssignmentProposition(vars.get(1), "Adult"),
//                new AssignmentProposition(vars.get(2), "Middle"),
//                new AssignmentProposition(vars.get(3), "True"),
//                new AssignmentProposition(vars.get(4), "Normal"),
//                new AssignmentProposition(vars.get(5), "True"),
//                new AssignmentProposition(vars.get(6), "Rural"),
//                new AssignmentProposition(vars.get(7), "False")
//        };

        //AssignmentProposition[] e = {};
        //Insurance


        //Diabetes
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Pigs
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

        //Munif
        //RandomVariable[] mapVar = {};
        //AssignmentProposition[] e = {};

//
//        Scanner myObj = new Scanner(System.in);
//        System.out.println("Enter a number of node of a polytree");
//
//        int numberOfNode = Integer.parseInt(myObj.nextLine());
//
//        RandVar[] X = new RandVar[numberOfNode];
//        for(int i=0; i < numberOfNode; i++)
//            X[i] = new RandVar("X"+i, new BooleanDomain());
//
//        FiniteNode startNode = new FullCPTNode(X[0], new double[]{0.8D, 0.2D});
//        FiniteNode prevNode = new FullCPTNode(X[1], new double[]{0.99D, 0.01D, 0.4D, 0.6D}, new Node[]{startNode});
//
//        for(int i=2; i < numberOfNode; i++)
//            prevNode = new FullCPTNode(X[i], new double[]{0.99D, 0.01D, 0.4D, 0.6D}, new Node[]{prevNode});
//
//        BayesNet polytree = new BayesNet(new Node[]{startNode});
//
//        startTime = System.nanoTime();
//
//        CategoricalDistribution resMpePolytree = new MpeEliminationAsk().ask(null, new AssignmentProposition[]{new AssignmentProposition(X[numberOfNode-1], true)}, polytree);
//
//        endTime = System.nanoTime();
//
//        System.out.println("MPE Probability: " +  resMpePolytree.getValues()[0]);
//        for(Map.Entry<RandomVariable,Object> varValue : resMpePolytree.getBestVarsValues()[0].entrySet())
//            System.out.println(varValue.getKey() + " -> " + varValue.getValue());
//
//        timeElapsed = (endTime - startTime)/1000000;
//        System.out.println("MPE polytree - Execution time in milliseconds: " + timeElapsed);
//
//        int mapVarsDim = 18;
//        RandVar[] mapVars = new RandVar[mapVarsDim];
//        System.arraycopy(X, 1, mapVars, 0, mapVarsDim);
//
//        startTime = System.nanoTime();
//
//        CategoricalDistribution resMapPolytree = new MapEliminationAsk().ask(mapVars, new AssignmentProposition[]{new AssignmentProposition(X[numberOfNode-1], true)}, polytree);
//
//        endTime = System.nanoTime();
//
//        System.out.println("MAP Probability: " +  resMapPolytree.getValues()[0]);
//        for(Map.Entry<RandomVariable,Object> varValue : resMapPolytree.getBestVarsValues()[0].entrySet())
//            System.out.println(varValue.getKey() + " -> " + varValue.getValue());
//
//        timeElapsed = endTime - startTime;
//        System.out.println("MAP polytree - Execution time in milliseconds: " + timeElapsed / 1000000);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }


    private static void runMPE(RandomVariable[] mpeVar, AssignmentProposition [] e, BayesianNetwork bn){
        long startTime, endTime, timeElapsed;
        startTime = System.nanoTime();

        CategoricalDistribution resMpe = new MpeEliminationAsk().ask(null, e, bn);

        endTime = System.nanoTime();

        System.out.println("MPE Probability: " +  resMpe.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMpe.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        timeElapsed = endTime - startTime;
        System.out.println("MPE - Execution time in ms: " + timeElapsed / 1000000f);

    }

    private static void runMAP(RandomVariable[] mapVar, AssignmentProposition [] e, BayesianNetwork bn){
        long startTime, endTime, timeElapsed;
        startTime = System.nanoTime();

        CategoricalDistribution resMap = new MapEliminationAsk().ask(mapVar, e, bn);

        endTime = System.nanoTime();

        System.out.println("MAP Probability: " +  resMap.getValues()[0]);
        for(Map.Entry<RandomVariable,Object> varValue : resMap.getBestVarsValues()[0].entrySet())
            System.out.println(varValue.getKey() + " -> " + varValue.getValue());

        timeElapsed = endTime - startTime;
        System.out.println("MAP - Execution time in ms: " + timeElapsed / 1000000f);
    }
}
