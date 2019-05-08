import controlP5.ControlP5;
import processing.core.PApplet;

import java.util.ArrayList;
import java.util.List;


float networkSize = 1000;
        //传感器节点个数
        int nodenum = 1500;
        //系统当前时间初始为0s
        int systemTime = 0;
        //能量消耗率最小值
        float minECR = 0.01f;
        //能量消耗率最大值
        float maxECR = 0.06f;
        //多跳阈值
        float THR_erRateEFF = 0.1f;
        
/**
 * GeneticVisual
 *
 * @author: onlylemi
 */


Point[] points;
ControlP5 cp5;

boolean running = false;

List<Point> lists;

void settings() {
	size(1500, 1500);
}

void setup() {
	lists = new ArrayList<Point>();
//	addPoint(50);



	cp5 = new ControlP5(this);
	cp5.addButton("onAdd").setPosition(5, 100);
	cp5.addButton("onStart").setPosition(5, 130);
	cp5.addButton("onStop").setPosition(5, 160);
	cp5.addButton("reStart").setPosition(5, 190);
	cp5.addButton("onClear").setPosition(5, 220);
}

void draw() {
	background(220);


		//stroke(255, 0, 0);     //线条颜色 rgb
		//strokeWeight(2);   //线条宽度
	
	fill(0);
	noStroke();
	for (int i = 0; i < lists.size(); i++) {
		ellipse(lists.get(i).x, lists.get(i).y, 5,5 );
	}

	stroke(0);
	fill(0);
	textSize(12);
	text("point length: " + lists.size(), 5, 20);
	
}



void onAdd() {
	if (!running) {
		addPoint();
		

		points = null;
	}
}

void onStop() {
	running = false;
}

void reStart() {
	if (points != null) {
		
		running = true;
	}
}

void onClear() {
	lists.clear();


	running = false;
	points = null;
}


void mousePressed() {
	if (!running && mouseX > 150) {
		addMousePoint();

		points = null;
	}
}

void addPoint() {
	Sensor[] newsensor = getPoint();
	for (int i = 0; i < newsensor .length; i++) {
	      lists.add(newsensor[i].location);
	}
}

void addMousePoint() {
	Point point = new Point();
	point.x = mouseX;
	point.y = mouseY;

	lists.add(point);
}

float[][] getDist(Point[] points) {
	float[][] dist = new float[points.length][points.length];
	for (int i = 0; i < points.length; i++) {
		for (int j = 0; j < points.length; j++) {
			dist[i][j] = distance(points[i], points[j]);
		}
	}
	return dist;
}

float distance(Point p1, Point p2) {
	return (float) Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}


public Sensor[] getPoint(){
  
        Sensor[] allSensor = WsnFunction.initSensors(networkSize, nodenum, minECR, maxECR);
//        System.out.println("随机创建的节点信息如下");
//        for(Sensor node:allSensor) {
//            System.out.println("编号:"+node.number+" 坐标:("+node.location.x+","+node.location.y+") 剩余能量阈值:"+node.remainingE/node.maxCapacity +" 剩余寿命:"+node.remainingE/node.ecRate);
//        }
      
        return allSensor;
       
        
}
