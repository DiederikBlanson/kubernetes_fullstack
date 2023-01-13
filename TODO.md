To be implemented:
- Postgresdb in a Secret instead of Config
- Set terminationGracePeriodSeconds to handle the case when a node goes down
- Refer to db service as 'postgres-svc' instead of the clusterIP
- Add external domain name and refer to cluster