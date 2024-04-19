Output of command : 
patronictl list : 
+ Cluster: psql-core03-uat-kong (6867488892458676291) ------+----+-----------+
|         Member                   |      Host           |  Role  |  State    | TL  | Lag in MB |
+---------------------------------+-------------------+---------+-----------+-----+--------------+
| psql-podname-blahbla-0 |  ##.##.###.## | Leader | running | 46  |                 |
| psql-podname-blahbla-1 |  ##.##.###.## |             | running | 21  |     14288  |
| psql-podname-blahbla-2 |  ##.##.###.## |             | running | 46  |         0      |
+---------------------------------+-------------------+----------+----------+-----+-------------+



##########################################################################################################################

In case of a failure : 

patronictl list : 
+ Cluster: psql-core03-uat-kong (6867488892458676291) ------+----+-----------+
|         Member                   |      Host           |  Role  |  State    | TL  | Lag in MB |
+---------------------------------+-------------------+---------+-----------+-----+--------------+
| psql-podname-blahbla-0 |  ##.##.###.## | Leader | failure   | 46  |                 |
| psql-podname-blahbla-1 |  ##.##.###.## |             | running | 21  |     14288  |
| psql-podname-blahbla-2 |  ##.##.###.## |             | running | 46  |         0      |
+---------------------------------+-------------------+----------+----------+-----+-------------+


The below script (pg_monitoring.sh) sends an email when it detects any node to be in failed state. 
##########################################################################################################################

vi pg_monitoring.sh
#!/bin/bash

while true; 
do

# Execute the command and filter the output if anything has failed :
failed_members=$(patronictl list | awk '/failed/')

# Check if any failed failures have occurred
if [ ! -z "$failed_members" ]; then
    
# Loop through each failed member
echo "$failed_members" | while IFS= read -r line; do

# Extract the member name
member=$(echo "$line" | awk '{print $2}')

# Print message indicating the member is not healthy
echo "Member $member is not healthy. Please check"
done | mail -s "Health Check Report" chinmaya.kr@rakuten.com
fi

sleep 30
done


