set +o history
redis-cli --cluster create $1 $2 $3 $4 $5 $6 --cluster-replicas 1 -a changeit
set -o history