#!/bin/bash 


#linkedin : https://www.linkedin.com/in/can-sayın-b332a157/
#cansayin.com


v1=$1
v2=$2
while :
do
echo "###################"
echo "1. Get Users Information"
echo "2. Current User's Roles List"
echo "3. Change Password"
echo "4. List All Roles"
echo "5. Grant Role For Bucket"
echo "6. Drop Role From Bucket"
echo "7. Grant Admin Role"
echo "8. Drop Admin Role "
echo "9. Create Local User"
echo "d. Delete Local User"
echo "c. Create External User" 
echo "x. Delete External User"
echo "0. Quit"
echo -n "Select your process:"
read -n 1 -t 15 a
printf "\n"
case $a in
1* )
read -p "enter host name:" hostname
read -p "enter username:" username
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $username-p $password --script="SELECT * FROM system:user_info"
;;
2* )
read -p "Enter Hostname:" hostname
read -p "Enter Username:" username
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $username-p $password --script="SELECT * FROM system:applicable_roles" 
;;
3* )
read -p "Enter Hostname:" hostname
read -p "Enter Username:" username
read -p "Old Password:" password
read -p "New Password:" newpassword
couchbase-cli user-change-password -c $hostname --username $username --password $password --new-password $newpassword
;;
4* )
echo "###---Couchbase User Role List---###"
echo "admin"
echo "bucket_admin"
echo "bucket_admin[*]"
echo "cluster_admin"
echo "replication_admin"
echo "ro_admin"
echo "view_admin"
echo "views_admin[*]"
echo "data_reader"
echo "data_reader[*]"
echo "data_writer"
echo "data_writer[*]"
echo "data_dcp_reader"
echo "data_dcp_reader[*]"
echo "data_backup[*]"
echo "data_backup[*]"
echo "data_monitoring"
echo "fts_admin"
echo "fts_searcher"
echo "fts_searcher[*]"
echo "query_manage_index"
echo "query_manage_index[*]"
echo "query_delete"
echo "query_delete[*]"
echo "query_insert"
echo "query_insert[*]"
echo "query_select"
echo "query_update"
echo "system_catalog"
echo "###------###"
;;
5* )
read -p  "Enter Hostname : " hostname
read -p  "Enter Admin Name :" adminname
read -p  "Enter Admin Password : " adminpassword
read -p  "Enter Username :" username
read -p  "Enter Bucket name : " bucketname
read -p  "Set Roles  ### write "," between roles,if you give multiple roles. ### : " roles
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $adminname -p $adminpassword --script="GRANT $roles ON $bucketname TO $username;"
;;
6* )
read -p  "Enter Hostname : " hostname
read -p  "Enter Admin Name :" adminname
read -p  "Enter Admin Password :" adminpassword
read -p  "Enter Username :" username
read -p  "Enter Bucket name : " bucketname
read -p  "Set Roles  ### write "," between roles,if you give multiple roles. ### : " roles
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $adminname -p $adminpassword --script="REVOKE $roles ON $bucketname FROM $username;"
;;
7* )
read -p  "Enter Hostname : " hostname
read -p  "Enter Admin Name :" adminname
read -p  "Enter Admin Password :" adminpassword
read -p  "Enter Username :" username
read -p  "Set Roles  ### write "," between roles,if you give multiple roles. ### : " roles
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $adminname -p $adminpassword --script="GRANT $roles TO $username;"
;;
8* )
read -p  "Enter Hostname :" hostname
read -p  "Enter Admin Name :" adminname
read -p  "Enter Admin Password :" adminpassword
read -p  "Enter Username :" username
read -p  "Set Roles  ### write "," between roles,if you give multiple roles. ### : " roles
cd $CB_HOME/bin
./cbq -engine http://$hostname:8093 -u $adminname -p $adminpassword --script="REVOKE $roles FROM $username;"
;;
9* )
read -p "Enter Hostname :" hostname
read -p "Enter Admin Name :" adminname
read -p "Enter Admin Password :" adminpassword
read -p "Enter Username To Create:" username
read -p "Set Password:" password
read -p "Set roles  ### write "," between roles,if you give multiple roles. ### : " roles
 
couchbase-cli user-manage -c $hostname:8091 -u $adminname -p $adminpassword --set --rbac-username $username --rbac-password $password --roles $roles --auth-domain local
;;
 
d* )
read -p "Enter Hostname :" hostname
read -p "Enter Admin Name :" adminname
read -p "Enter Admin Password :" adminpassword
read -p "Enter Username To Delete :" username
couchbase-cli user-manage -c $hostname:8091 -u $adminname  -p $adminpassword --delete --rbac-username $username --auth-domain local
;;
c* )
read -p "Enter Hostname :" hostname
read -p "Enter Admin Name :" adminname 
read -p "Enter Admin Password :" adminpassword 
read -p "Enter Username To Create:" username 
read -p "Set Password:" password 
read -p "Set roles ### write "," between roles,if you give multiple roles. ### : " roles
couchbase-cli user-manage -c $hostname:8091 -u $adminname -p $adminpassword --set --rbac-username $username --rbac-password $password --roles $roles --auth-domain external
;; 
x* )
read -p "Enter Hostname :" hostname
read -p "Enter Admin Name :" adminname 
read -p "Enter Admin Password :" adminpassword 
read -p "Enter Username To Delete :" username 
couchbase-cli user-manage -c $hostname:8091 -u $adminname -p $adminpassword --delete --rbac-username $username --auth-domain external
;;
0* )
 echo "###---Bye---###";
     exit 0;;
esac
done
