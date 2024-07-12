build:
	docker build -t samarsinghal/lab-workshop-builder .
	docker tag samarsinghal/lab-workshop-builder samarsinghal/lab-workshop-builder:latest

clean:
	docker stop samarsinghal/lab-workshop-builder
	docker rm samarsinghal/lab-workshop-builder

rebuild: clean build

run:
	docker exec -it samarsinghal/lab-workshop-builder bash -l
demo: 
	docker exec -it samarsinghal/lab-workshop-builder bash -l	
join:
	docker exec -it samarsinghal/lab-workshop-builder bash -l

start:
	docker start samarsinghal/lab-workshop-builder:latest

stop:
	docker stop samarsinghal/lab-workshop-builder

default: build