# Databricks notebook source

job_params = dbutils.widgets.getAll()

job_var = job_params.get("job_var", "job_var not fetched")

print("HELLO WORLD")
print(f"VALUE OF JOB VAR IS `{job_var}`")