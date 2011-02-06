#include "testApp.h"

bool fillShape = true;
float sizeX = 100.0f;
float sizeY = 100.0f;
bool circle = false;
bool useColorPicker = false;
int r = 0;
int g = 0;
int b = 0;
ofColor color = ofColor(0, 0, 0);
int  box2 =0;
//--------------------------------------------------------------
void testApp::setup(){	 
	ofSetVerticalSync(true);
	//gui.addPage("BETA");
	//gui.addToggle("useColorPicker", useColorPicker);
	//gui.addColorPicker("colorPicker", &color.r);
	
	gui.addPage("SHAPES");
	gui.addToggle("Fill", fillShape);
	gui.addToggle("Circle", circle);
	
	gui.addSlider("sizeX", sizeX, 50.0f, 800.0f);
	gui.addSlider("sizeY", sizeY, 50.0f, 600.0f);
	
	gui.addPage("COLORS");
	gui.addSlider("red", r, 0, 255);
	gui.addSlider("green", g, 0, 255);
	gui.addSlider("blue", b, 0, 255);
	string titleArray[] = {"Lame", "Alright", "Better", "Best"};
	gui.addComboBox("Options", box2, 4,  titleArray);
	box2 = 2;
	gui.setPage(1);
	gui.startServer();
	tuioClient.connect(3333);
	tuioClient.setVerbose(true);
	
	
	//Assign Global TUIO Callback Functions
	//ofAddListener(ofEvents.touchDown,this,&testApp::touchDown);
	ofAddListener(tuioClient.cursorAdded, this, &testApp::touchDown);
	//ofAddListener(tuioClient.cursorUpdated,this,&testApp::touchUp);
	ofAddListener(tuioClient.cursorUpdated, this,&testApp::touchMoved);
	ofAddListener(tuioClient.cursorUpdated, this, &testApp::cursorUpdateHandler);
}

//--------------------------------------------------------------
void testApp::update(){


}

//--------------------------------------------------------------
void testApp::draw(){
	if(fillShape) ofFill();
	else ofNoFill();
	if (useColorPicker) {
		ofSetColor(color);
	}else {
		ofSetColor(r, g, b);
	}

	
	if(circle) {
		ofEllipse(ofGetWidth()/2, ofGetHeight()/2, sizeX, sizeY);
	} else {
		ofRect((ofGetWidth()-sizeX)/2, (ofGetHeight()-sizeY)/2, sizeX, sizeY);
	}
	
	tuioClient.drawCursors();
	tuioClient.drawObjects();
	ofPushStyle();
		//ofSetColor(ofRandom(0, 255), ofRandom(0, 255), ofRandom(0, 255));
		ofSetColor(0xFF5566ee);
		ofBeginShape();
		ofNoFill();
		//ofSetPolyMode(OF_POLY_WINDING_NONZERO);
		
		for(int i=0; i<touchPoints.size(); i++)
		{
			ofVertex(touchPoints[i].x, touchPoints[i].y);
		}
		ofEndShape();
	ofPopStyle();
	string info = "";
	info = "FPS: " + ofToString(ofGetFrameRate(), 2) + "\n";
	info.append("numPoints " + ofToString(touchPoints.size(), 0));
	ofDrawBitmapString(info, 20, 20);
	
	gui.draw();
	
}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
	if (key == 'g') {
		gui.toggleDraw();
	}
}

//--------------------------------------------------------------
void testApp::keyReleased  (int key){ 
	
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(){

}
void testApp::exit()
{
	tuioClient.disconnect();
}
void testApp::cursorUpdateHandler(TuioCursor & tcur)
{
	/*std::cout << "cursorUpdated " << tcur->getCursorID() << " (" <<  tcur->getSessionID() << ") " << tcur->getX() << " " << tcur->getY() 
	 << " " << tcur->getMotionSpeed() << " " << tcur->getMotionAccel() << " " << std::endl;*/
	
	cout << "testApp::cursorUpdateHandler: " << " tcur.getX(): " << tcur.getX() << " tcur.getY(): " << tcur.getY() << endl;
	
	touchPoints.push_back(ofPoint(tcur.getX()*ofGetWidth(), tcur.getY()*ofGetHeight()));
	//touchPoints.push_back( ofPoint(tcur.getX(), tcur.getY()) );
	//cout << "tcur.getX(): " << tcur.getX() << " tcur.getY() : " << tcur.getY() << endl;
}

void testApp::touchDown(TuioCursor & tcur)
{

	cout << "testApp::touchDown" << endl;
	touchPoints.push_back( ofPoint(tcur.getX()*ofGetWidth(), tcur.getY()*ofGetHeight()) );
	
}

void testApp::touchUp(TuioCursor & tcur)
{
	cout << " testApp::touchUp:touch.id " << endl;
	//touchPoints.push_back( ofPoint(tcur.getX()*ofGetWidth(), tcur.getY()*ofGetHeight()) );

}

void testApp::touchMoved(TuioCursor & tcur){
	touchPoints.push_back( ofPoint(tcur.getX()*ofGetWidth(), tcur.getY()*ofGetHeight()) );
	
}