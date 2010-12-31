/*
 *  ofxWebSimpleGuiToo.cpp
 *  ofxWebSimpleGuiTooExample
 *
 *  Created by Marek Bereza on 27/03/2010.
 *  Copyright 2010 Marek Bereza. All rights reserved.
 *
 */
#include "ofxWebSimpleGuiToo.h"



ofxWebSimpleGuiToo::ofxWebSimpleGuiToo() {
}
void ofxWebSimpleGuiToo::startServer(int port) {
	server.start("ofxWebSimpleGuiToo", port);
	server.addHandler(this, "/control");
}

void ofxWebSimpleGuiToo::stopServer(){
	server.stop();
}
void ofxWebSimpleGuiToo::httpGet(string url) {
	
	string key = getRequestParameter("key");
	if(key=="") {
		string guiDesc = "[";
		for(int i = 0; i < pages.size(); i++) {
			guiDesc += describePage(pages[i]);
			if(i+1<pages.size()) {
				guiDesc += ",";
			}
		}
		guiDesc += "]";
		httpResponse(guiDesc);
	} else {

		string value = getRequestParameter("value");
		//printf("value received: %s = %s\n", key.c_str(), value.c_str());
		cout << "key.c_str(): " << key.c_str() << " value.c_str(): " << value.c_str() <<endl;
		ofxSimpleGuiControl *ctrl = findControlByName(key.c_str());

		if(ctrl!=NULL) {
			if(ctrl->controlType=="Toggle") {
				
				ofxSimpleGuiToggle *t = (ofxSimpleGuiToggle*)ctrl;
				*(t->value) = (value=="true");
				
			} else if(ctrl->controlType=="SliderInt") 
			{
				ofxSimpleGuiSliderInt *t = (ofxSimpleGuiSliderInt*)ctrl;
				*(t->value) = atoi(value.c_str());
				
			} else if(ctrl->controlType=="SliderFloat") 
			{
				
				ofxSimpleGuiSliderFloat *t = (ofxSimpleGuiSliderFloat*)ctrl;
				*(t->value) = atof(value.c_str());
				
			} else if(ctrl->controlType=="ComboBox") 
			{
				ofxSimpleGuiComboBox *t = (ofxSimpleGuiComboBox*)ctrl;
				t->setValue(atoi(value.c_str()));
				
			} else if(ctrl->controlType=="Button") 
			{
				ofxSimpleGuiToggle *t = (ofxSimpleGuiToggle*)ctrl;
				*(t->value) = true;
			}
		}
		httpResponse("thanks");
	}
}
ofxSimpleGuiControl * ofxWebSimpleGuiToo::findControlByName(string name)
{
	for(int i = 0; i < pages.size(); i++) {
		
		for (int j=0; j<pages[i]->getControls().size(); j++) 
		{
			cout << "name: " << pages[i]->getControls()[j]->name <<endl;
			if (pages[i]->getControls()[j]->name == name) {
				return pages[i]->getControls()[j];
			}
		}
		
	}
	return NULL;
}
string ofxWebSimpleGuiToo::describePage(ofxSimpleGuiPage *page) {
	string desc = "{\"name\": \""+page->name+"\", \"controls\":[";
	for(int i = 0; i < page->getControls().size(); i++) {
		desc += describeControl(page->getControls()[i]);
		if(i+1<page->getControls().size()) {
			desc += ",";
		}
	}
	desc += "]}";
	return desc;
}
string ofxWebSimpleGuiToo::describeControl(ofxSimpleGuiControl *ctrl) {
	string desc = "{\"name\":\""+ctrl->name + "\",";
	desc += "\"type\": \""+ctrl->controlType+"\"";
	
	if(ctrl->controlType=="Toggle") 
	{
		ofxSimpleGuiToggle *t = (ofxSimpleGuiToggle*)ctrl;
		if(*t->value) desc += ", \"value\":\"true\"";
		else desc += ", \"value\":\"false\"";
		
	} else if(ctrl->controlType=="SliderInt") 
	{
		ofxSimpleGuiSliderInt *t = (ofxSimpleGuiSliderInt*)ctrl;
		desc += ", \"value\":\""+ofToString(*(t->value))+"\"";
		desc += ", \"min\":\""+ofToString(t->min)+"\"";
		desc += ", \"max\":\""+ofToString(t->max)+"\"";
		
	} else if(ctrl->controlType=="SliderFloat") 
	{
		ofxSimpleGuiSliderFloat *t = (ofxSimpleGuiSliderFloat*)ctrl;
		desc += ", \"value\":\""+ofToString(*(t->value))+"\"";
		desc += ", \"min\":\""+ofToString(t->min)+"\"";
		desc += ", \"max\":\""+ofToString(t->max)+"\"";
		
	} else if(ctrl->controlType=="ComboBox") 
	{
		ofxSimpleGuiComboBox *t = (ofxSimpleGuiComboBox*)ctrl;
		desc += ", \"value\":\""+ofToString(t->getValue())+"\"";
		
		string choicesString ="";
		//ofxSimpleGuiComboBox::getChoices is a custom implementation
		for (int i=0; i<t->getChoices().size(); i++) 
		{
			choicesString += ("\""+t->getTitleForIndex(i)+"\"");
			if(i+1<t->getChoices().size()) {
				choicesString +=",";
			}
		}
		desc += ", \"choices\":[" + choicesString +"]";
		
	}
	desc += "}";
	return desc;
}

