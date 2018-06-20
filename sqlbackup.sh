user=root
pass=
host=localhost
dir=/home/backup_sql

backup(){
date=$(date +%Y%m%d-%H%M)
tanggal=$(date +%d)
bulan=$(date +%m)
tahun=$(date +%Y)
if [ ! -d "$dir/$tahun/$bulan/$tanggal/" ];
then mkdir --parents $dir/$tahun/$bulan/$tanggal;
fi
dump=/usr/bin/mysqldump
$dump $dbs -u$user -p$pass -h$host -R -K --triggers> $dir/$tahun/$bulan/$tanggal/$dbs-$date.sql
gzip -f $dir/$tahun/$bulan/$tanggal/$dbs-$date.sql
}


#######jika seluruh db dalam grant tersebut ingin dibackup
sql=/usr/bin/mysql

for dbs in $($sql -u$user -p$pass -e 'show databases' | sed 1d); 

do if [ "$dbs" != "mysql" ] && [ "$dbs" != "information_schema" ] && [ "$dbs" != "performance_schema" ]; 

then backup; 

fi; 

done;

#######jika database ditentukan yang akan dibackup

#database="db1 db2 db3"
#for dbs in $database
#do
#backup
#done
exit 0

