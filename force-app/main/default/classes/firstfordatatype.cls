public class firstfordatatype {
    
    public static void firstapex(){
        System.debug('This is my first apex program');
        
        integer a=15;
        System.debug(a);
        
        long b=123456789122l;
        System.debug(b);
        
        double c=3.14;
        System.debug(c);
        
        decimal d=25000.78;
        System.debug(d.round());    
        
        boolean e= False;
        System.debug(e);
        
        String f='this is string';
        System.debug(f);
        
        Date g=Date.newInstance(2004,04,22);
        System.debug(g);
        
        Time h=Time.newInstance(12,12,12,12);
        System.debug(h);
        
        dateTime i=datetime.newInstance(2004,04,22,12,12,12);
        System.debug(i);
        
        Id j = '0012w00001UNkDQAA1';
        System.debug(j);
    }

}