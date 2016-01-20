<!DOCTYPE html>
<html>
	<head>
		<title>CS143 Project 1B by Guan Zhou & Kwai Shea</title>
	</head>
	<body>
		<p>Type an SQL query in the following box:<br><br>
		Example: SELECT * FROM Actor WHERE id=10;</p>
		<form action="#" method="GET">
			<textarea name="query" rows="10" cols="60"></textarea><br>
			<input type="submit" value="Submit" />
		</form>
		<p><small>Note: tables and fields are case sensitive. All tables in Project 1B are availale.</small></p>


<?php
/************Define the host, username, passwaord, and database************/
define( 'DB_HOST', 'localhost', FALSE);
define( 'DB_USER', 'cs143', FALSE);
define( 'DB_PASS', '', FALSE);
define( 'DB_NAME', 'TEST', FALSE);
?>

<?php
// get the input query
if($query = $_GET["query"]){

	// connect to the database, and check if connection is successful
	$db_connection = mysql_connect(DB_HOST, DB_USER, DB_PASS);
	if(!$db_connection) {
		die('Not connected : ' . mysql_error());
	}

	// select datebase 'DB_NAME' as the current database, and check if selection is successful
	if (!$db_chosen = mysql_select_db(DB_NAME, $db_connection)) {
	    die ('Can\'t use' . $DB_NAME .':' . mysql_error());
	}
	

	echo "Query being executed: <code>$query</code><br>";
	echo "<h3>Results from MySQL:</h3>";
	
	$result = mysql_query($query);

	# check if query if valid or not
	if ($result == FALSE){
		die('Could not run query! <br/>' . mysql_error());
	}

	//set the output table format 
	echo '<table border=1 cellspacing=1 cellpadding=2><tr>';
	//Code referenced from php.net: http://php.net/manual/en/function.mysql-fetch-field.php
	for ($i = 0; $i < mysql_num_fields($result); $i++){
		$meta = mysql_fetch_field($result, $i);
		if (!$meta) {
        	echo "No information available<br/>\n";
    	}
		echo '<td align="center"><b>' . $meta->name . '</b></td>';	
	}
	echo '<tr>';

	# read row by row
	while ($row = mysql_fetch_row($result)){
		# print all the elements in each row
		foreach ($row as $value)
		{
			if ($value) echo '<td align="center">' . $value . '</td>';	
			else echo '<td align="center">' . 'N/A' .'</td>';	
		}
		echo '<tr>';
	}
	echo '</table>';
	//free up result memory
	mysql_free_result($result);
	// close database
	mysql_close($db_connection);
}
?>
	</body>
</html>
