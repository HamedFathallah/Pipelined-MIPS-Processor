<?php
$thedata = 0;
$address = 0;
if(isset($_GET['address']))
{
$servername = "localhost";
$username = "root";
$password = "";

$dbname = "data";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$address = $_GET['address'];
if($_GET['radio']=="read")
{
//select from db likes , dislikes 

$sql = "SELECT data FROM my_data WHERE id = ".$_GET['address'];
$result2 = $conn->query($sql);

if ($result2->num_rows > 0) {
    while($row = $result2->fetch_assoc()) {
        $thedata = $row["data"];
    }
}
}
if($_GET['radio']=="write")
{
//select from db likes , dislikes 

$sql = "UPDATE my_data SET data = ".$_GET['data']." WHERE id = ".$_GET['address'];
$result2 = $conn->query($sql);
    echo "your data updated successfully !!";
    
}
}


echo"
<!DOCTYPE html>
<html lang='en'>
<head>
  <title>Bootstrap Example</title>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css'>
  <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'>
  </script>
  <script>
$(document).ready(function(){
  $('#btn1').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c= a &b;
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });
 $('#btn2').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c= a|b;
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });
   $('#btn3').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c= b - - a;
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });
  $('#btn4').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c= a - b;
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });
   $('#btn5').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c = a<b;
  
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });

  $('#btn6').click(function(){ var a =$('#num1').val();
  var b = $('#num2').val(); 
  var c= ~(a|b);
    $('#set1').text( c);
	var d ;
	d= c==0;
	$('#set2').text( d);
  });
    
});
</script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
  <script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>
</head>
<body>

<div class='container-fluid'>
  <div class='row'>
    <div class='col' style='background-color:lavender;'>
    <h1> The Register File  </h1>
   <ul class='list-group'>
   <form action='register.php' method='GET'>
    <li class='list-group-item list-group-item-primary'>address  <input class='btn float-right' type='number' name='address' id='num1' value='".$address."'> </li>
    <li class='list-group-item list-group-item-success'>data<input class='btn float-right' type='number' id='num2' name='data' value='".$thedata."'> </li>
    
    <input type='radio' name='radio' value='write' id='btn2'>write
    <br> <input type='radio' name='radio' value='read' id='btn5'>read
    <br>
    <button type='submit' id='btn2'>submit</button>
    </form>

	
  </ul>

  
    </div>



    
     
    
     
     </div>
</div>

</body>
</html>";
?>



<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
  </script>
  <script>
$(document).ready(function(){
  $("#btn1").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c= a &b;
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });
 $("#btn2").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c= a|b;
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });
   $("#btn3").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c= b - - a;
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });
  $("#btn4").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c= a - b;
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });
   $("#btn5").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c = a<b;
  
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });

  $("#btn6").click(function(){ var a =$("#num1").val();
  var b = $("#num2").val(); 
  var c= ~(a|b);
    $("#set1").text( c);
	var d ;
	d= c==0;
	$("#set2").text( d);
  });
    
});
</script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container-fluid">
  <h1>Welcome to Our Basic Gui For Alu and Register File</h1>  
  <p class="font-italic">For ALU, Please enter the 2 inputs and the operation </p>
  <div class="row">
    <div class="col" style="background-color:lavender;">
    <h1> The Alu Inputs </h1>
   <ul class="list-group">
    <li class="list-group-item list-group-item-primary">Input A   <input class="btn float-right" type="number" id="num1" value="The Stranger "> </li>
    <li class="list-group-item list-group-item-success">Input B <input class="btn float-right" type="number" id="num2" value=""> </li>
 <li class="list-group-item list-group-item-success">Output F <h3 id ="set1"> Out</h3> </li>
	 <li class="list-group-item list-group-item-success">Zero flag <h3 id ="set2"> Out</h3> </li>
  </ul>

<button id="btn1">And</button>  <button id="btn2">Or</button> <button id="btn3">Add</button> <br>
<button id="btn4">Sub</button> <button id="btn5">Slt</button> <button id="btn6">Nor</button> 
    </div>



   
    
  </div>
</div>

</body>
</html>