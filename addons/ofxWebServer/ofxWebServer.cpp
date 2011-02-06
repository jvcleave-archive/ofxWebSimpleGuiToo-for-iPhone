/*
 *  ofxWebServer.cpp
 *  webServerExample
 *
 *  Created by Marek Bereza on 26/03/2010.
 *  Copyright 2010 Marek Bereza. All rights reserved.
 *
 */

#include "ofxWebServer.h"
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>


void ipLongToString(unsigned int ip, char *ipString) {
	unsigned int a, bb, c, d;
	a = ip/16777216;
    ip = ip%16777216;
    bb = ip/65536;
    ip = ip%65536;
    c = ip/256;
    ip = ip%256;
	d = ip;
	sprintf(ipString, "%i.%i.%i.%i", a, bb, c, d);
}

// callback from server
void webserverCallback(struct mg_connection *conn,
					   const struct mg_request_info *info, 
					   void *user_data) {
	
	in_addr_t addr = info->remote_ip; 
	const char *buf = addr2ascii(AF_INET, &addr, sizeof(addr), NULL);
	cout << "buf: " << buf << endl;
	
	char *ipString = new char[sizeof(info->remote_ip)];
	unsigned int ip = info->remote_ip;
	ipLongToString(ip, ipString); 

	
	cout << "ipString: " << ipString << endl;
	
	string query = "";
	if(info->query_string!=NULL) query = info->query_string;
		
	((ofxWSRequestHandler*)user_data)->setConnection(conn, ipString, query);
	
	if(strcmp(info->request_method,"GET")==0 || strcmp(info->request_method,"get")) {
		((ofxWSRequestHandler*)user_data)->httpGet(info->uri);
	} else if(strcmp(info->request_method,"POST")==0 || strcmp(info->request_method,"post")) {
		((ofxWSRequestHandler*)user_data)->httpPost(info->uri, info->post_data, info->post_data_len);
	} else {
		printf("ofxWebServer: unhandled '%s' request method\n", info->request_method);
	}
}

ofxWebServer::ofxWebServer() {

}

void ofxWebServer::start(string root, int port) {
	ctx = mg_start();     // Start Mongoose serving thread
	mg_set_option(ctx, "root", ofToDataPath(root, true).c_str());  // Set document root
	mg_set_option(ctx, "ports", ofToString(port).c_str());    // Listen on port XXXX
}

void ofxWebServer::stop() {
	mg_stop(ctx);
}

void ofxWebServer::addHandler(ofxWSRequestHandler *handler, string pattern) {
	
	// make sure there's a forward slash at the beginning
	if(pattern.size()==0) {
		pattern = "/";
	} else if(pattern[0]!='/') {
		pattern = "/" + pattern;
	}
	
	mg_set_uri_callback(ctx, pattern.c_str(), webserverCallback, handler);
}

string ofxWebServer::getIPAddress() {
	char baseHostName[255];
	gethostname(baseHostName, 255);
	
	// Adjust for iPhone -- add .local to the host name
	char hn[255];
	sprintf(hn, "%s.local", baseHostName);
	
	struct hostent *host = gethostbyname(hn);
	if (host == NULL)
	{
		herror("resolv");
		return NULL;
	} else {
		struct in_addr **list = (struct in_addr **)host->h_addr_list;
		return inet_ntoa(*list[0]);
	}
}
/*
void ofxWebServer::callback(struct mg_connection *conn,
			  const struct mg_request_info *info) {
	mg_printf(conn, "<html><body>chrcxdflfkjThis is <b>HTML</b>!</body></html>\n");
}

*/