#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "ofxWebSimpleGuiToo.h"
#include "ofxTuioClient.h"

class testApp : public ofSimpleApp{
	
public:
	
	void setup();
	void update();
	void draw();
	
	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void exit();
	
	ofxWebSimpleGuiToo gui;
	ofxTuioClient tuioClient;
	
	void touchDown(TuioCursor & tcur);
	void touchUp(TuioCursor & tcur);
	void touchMoved(TuioCursor & tcur);
	void cursorUpdateHandler(TuioCursor &tcur);
	vector<ofPoint> touchPoints;
	
};

#endif

