public class secondforcollection {
    
    public static void secondapex(){
        
        List<String> list1=new List<String>{'random','things'};
        list1.add('uday');
        list1.add('day');
        list1.add('ay');
        list1.add('y');
        
        system.debug(list1);
        system.debug(list1.get(2));
        
        
        set <integer> set1=new set<integer>{4,6,7,8,10,3};
        set1.add(0);
        set1.add(1);
        set1.add(2);
        set1.add(3);
        set1.remove(3);
        
        system.debug(set1);
        
        map <integer,string> map1=new map <integer,string>{04 =>'bye'};
        map1.put(01,'Hi');
        map1.put(02,'Hello');
        map1.put(03,'Hey'); 	
        
        system.debug(map1);
        
    }

}