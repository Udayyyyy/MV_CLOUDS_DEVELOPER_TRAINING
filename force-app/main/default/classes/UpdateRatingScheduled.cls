global class UpdateRatingScheduled implements Schedulable {
    global void execute(SchedulableContext sc) {
            List<Lead> leadsToUpdate = [SELECT Id, Rating, AnnualRevenue FROM Lead WHERE AnnualRevenue > 10000 AND AnnualRevenue <= 100000];
            
 
            for (Lead lead : leadsToUpdate) {
                lead.Rating = 'warm';
               
            }
             
             update leadsToUpdate;
        }
    }