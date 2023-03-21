<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Javascript Test</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#btn_click').on('click',function(){
			alert('query event ready~');
		});
		
		$('#btn_push').on('click',function(){
			const array = ['a','b','c']
			//alert(array[0]);
			alert(array.length);
			for(let i=0;i<array.length;i++){
				//console.log(array[i]);
			}
			//console.log(array[0]);
			
			for(let index in array){
				//console.log(array[index]);
			}
			
			
			//추가 할 때_index
			array[array.length] = 'd';
			array.push('e');
			
			
			//delete array[0];
			let ele = array.pop();
			alert(ele);
			for(let item of array){
				console.log(item);
			}
		});
		
		$('#btn_object').on('click',function(){
			const person = {
					fname : "Jonh",
					lname : " Doe",
					age : 25,
					fullName : function() {
					    return this.fname + " " + this.lname;
					},
					add : function(x,y){
						return x + y;
					}
			};
			let txt = "";
			for(let x in person){
				console.log(x);
				txt += person[x];
			}
			alert(person.add(10,20));
		});
		
		$('#btn_checkId').on('click',function(){
			let user_id = $('#user_id').val();
			$.ajax({
				url : './checkID',
				type : 'get',
				data : {'user_id':user_id},
				success : function(data){
					alert(data);
				},
				error : function(){
					alert('error');
				},
				complete : function(){
					//alert('complete!');
				}
			});
		});
		
		$('#btn_findBoard').on('click',function(){
			//seq값 구하기
			let seq = $('#seq').val();
			//ajax로 서버전달하기
			$.ajax({
				url : './searchAjax.do',
				type : 'get',
				data : {'seq':seq},
				success : function(data){
					let obj = JSON.stringify(data);
					alert(obj);
					alert(data.seq);
				},
				error : function(){
					alert('error');
				},
				complete : function(){
					
				}
			});
			
		});
		
		$('#btn_readAll').on('click',function(){

			//ajax로 서버전달하기
			$.ajax({
				url : './listAjax.do',
				type : 'get',
				success : function(data){
					let obj = JSON.stringify(data);
					alert(obj);
					//alert(data.seq);
					let len = data.length;
					alert(len);
					for (let item of data){
						let temp = JSON.stringify(item);
						alert(temp);
					}
					
				},
				error : function(){
					alert('error');
				},
				complete : function(){
					
				}
			});
			
		});
		
		$('#btn_list').on('click',function(){

			//ajax로 서버전달하기
			$.ajax({
				url : './listAjax.do',
				type : 'get',
				success : function(data){
					//let obj = JSON.stringify(data);
					//alert(obj);
					let display="<table><tr><th>순번</th><th>제목</th><th>내용</th><th>작성자</th><th>조회수</th><th>작성일자</th><th>이미지첨부</th><th>데이터첨부</th><th>비고</th></tr>"
					for(let items of data){
						console.log(items);
						display = display +"<tr id='tr_"+items['seq']+"'>";
						for(let item in items){
							let temp = items[item]
							if(item=='createDate'){
								display += "<td>"+new Date(temp).toLocaleString()+"</td>"
							} else {
								display += "<td>"+(temp==null?'':temp)+"</td>"
							}
							
						}
						display += "<td><button id='"+items['seq']+"' class='btn_remove'>삭제</button></td>";
						display += "</tr>";
					}
					display += "</table>";
					console.log(display);
					$('#list_place').html(display);
				},
				error : function(){
					alert('error');
				},
				complete : function(){
					event_remove();
				}
			});
			
		});
		
		let event_remove = function(){
			let buttons = $('.btn_remove');
			for(let i=0;i<buttons.length;i++){
				$(buttons[i]).on('click',function(){
					console.log(buttons[i].id);
					$('#tr_'+buttons[i].id).remove();
				});
				
			}
		};
		
	});
	
	
</script>
</head>
<body>
<h1>Javascript</h1>
<button id="btn_click">Btn1</button>
<button id="btn_push">Array Check</button>
<button id="btn_object">Object Check</button>
<br><br>
<input type="text" name="user_id" id="user_id">
<button id="btn_checkId">ID Check</button>
<br><br>
<input type="text" name="seq" id="seq">
<button id="btn_findBoard">findBoard</button>
<br><br>
<button id="btn_readAll">Read All Board</button>
<br><br>
<button id="btn_list">list 출력</button>
<br><br>

<div id="list_place"></div>
</body>
</html>



