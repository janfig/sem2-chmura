# Sprawozdanie Lab5
Jan Figura GL01\92859 14.11.2023

# zad4
Wartość *maxReplicas* została usawiona na 5 Ponieważ:\
Quota ogranicza dostępne zasoby: CPU:2000m i MEM:1,5Gi\
Pod *worker* z zadania 2 może zabrać maksymalnie: CPU: 200m i MEM:200Mi\
Więc zostaje nam:\
CPU = 2000m - 200m = 1800m\
MEM = 1500Mi - 200Mi = 1300Mi\
Pojedyńczy pod deploymentu ma limity CPU: 250m i MEM:250Mi , a więc CPU = 1800m / 250m = 7 i MEM = 1300Mi / 250Mi = 5\
Jak widać w przypadku dużego opciążenia przed stowrzeniem więkeszje ilości replik będzie nas ograniczać pamięć. Dlatego maksymalna ilość replik nie powinna przekraczać 5 

# zad5
Tworzymy po kolei obiekty z wysztkich zadań za pomocą polecenia: `kubectl create -f <nazwa-pliku.yaml>`, aby sprawdzić poprawne utworzenie wszystkich obiektów możęmy użyć polecenia `kubectl get all -n zad5`. W rezultacie powinniśmy otrzymać:
```
NAME                              READY   STATUS    RESTARTS   AGE
pod/php-apache-55f6b55c97-vz9dx   1/1     Running   0          55m
pod/worker                        1/1     Running   0          72m

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/php-apache   ClusterIP   10.103.48.90   <none>        80/TCP    55m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/php-apache   1/1     1            1           55m

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/php-apache-55f6b55c97   1         1         1       55m

NAME                                             REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/php-apache   Deployment/php-apache   0%/50%    1         7         1  	  73s
```
# zad6
Wywołujemy obciążenie na deploymencie serwera apache komendą:\
`kubectl run -i --tty load-generator-1 --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache.zad5; done"`\
Utworzy ona poda w przestrzeni default(aby nie zabierać zasobów z zad5) i korzystając w dnsa będzie wysyłać requesty pod adres php-apache.zad5

Aby spradzić działanie konfiguracji możemy użyć komend:\
`kubectl get horizontalpodautoscalers.autoscaling -n zad5 --watch` - Status z Hpa o ilości utworzonych replik\
`kubectl describe quota -n zad5` - Zasoby dostępne i używane w ramach ograniczeń quota
`kubectl top pods -n zad5` - Zużucie zasobów przez repliki

