package lib.kontentum;

enum KontentumStatus
{
	Success;
	TimeOutJSONLoadedLocally;
	FailedToGetJSONRest;
}

typedef KontentumExhibitInfo =
{
	@:optional	var id			: Int;
	@:optional	var app_id		: Int;
	@:optional	var liveupdate	: Bool;
	@:optional	var name		: String;
	@:optional	var exhibit_id	: Int;
	@:optional	var client_id	: Int;
	@:optional	var variables	: Dynamic;
	@:optional	var select		: Dynamic;
	@:optional	var blacklist	: Array<String>;
}

typedef KontentumHighscoreEntry =
{
				var name		: String;
				var score		: Int;
	@:optional	var metaData	: Dynamic;
}

enum KontentumLanguage
{
	CURRENT;
	NO;
	EN;
	SE;
	DK;
}

typedef KontentumExhibitJSON =
{
	var	app_id					: String;
	var liveupdate				: String;
	var name					: String;
	var last_modified			: String;
	var exhibit_id				: String;
	var success					: Bool;
	var exhibit					: KontentumExhibitInfo;
	var content					: Dynamic;
	var languages				: Array<KontentumExhibitLanguage>;
	var texts					: Array<KontentumExhibitTextEntry>;
	var files					: Array<KontentumExhibitFileEntry>;
}

typedef KontentumExhibitLanguage =
{
	var label					: String;
	var identifier				: String;
}

typedef KontentumExhibitTextEntry =
{
	var id						: Int;
	var identifier				: String;
	var text					: Dynamic;
}

typedef KontentumExhibitFileEntry =
{
	var id						: String;
	var identifier				: String;
	var title					: String;
	var credit					: String;
	var description				: String;
	var file					: String;
	var filename				: String;
	var modified				: String;
	var type					: String;
}

typedef KontentumText =
{
	var id						: Int;
	var identifier				: String;
	var texts					: Map<KontentumLanguage,String>;
}

typedef KontentumFile =
{
	var id 						: Int; 
	var identifier 				: String; 
	var title					: String; 
	var credit 					: String; 
	var description				: String; 
	var file 					: String; 
	var filename 				: String; 
	var modified 				: String; 
	var type 					: String;	
}

typedef ScoreboardResults = 
{
	var success					: Bool;
	var interval				: String;
	var rows					: Int;
	var scoreboard				: Array<ScoreboardResultEntry>;
} 

typedef ScoreboardResultEntry =
{
	var name					: String;	
	var score					: Int;	
	var metadata				: String;	
	var timestamp				: String;	
}

typedef SubmitScoreResults = 
{
	var success					: Bool;
	var rank					: SubitScoreResultsRank;
}	

typedef SubitScoreResultsRank =
{
	var D						: Int;	
	var W						: Int;	
	var M						: Int;	
	var Y						: Int;	
	var A						: Int;	
}



/*
"id": "4363",
"title": "",
"credit": "",
"description": "",
"file": "o_1fvkjdrhe1s9f15eg58r15hl8f48.jpg",
"filename": "_K5A9034.jpg",
"identifier": "",
"modified": "20220402093934",
"type": "image"
*/