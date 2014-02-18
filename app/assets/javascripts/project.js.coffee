




###
	Updates the Task on the project view. 
	It will open the modal and pass the calling Task
	params to the form.
###



updateTask = (id, titel, text) ->
	taskTitel = document.getElementById('task_titel')
	taskTitel.value = titel
	taskText = document.getElementById('task_text')
	taskText.value = text
	taskId = document.getElementById('task_id')
	taskId.value = id
	$('#editTaskModal').modal('show')
    

window.updateTask = updateTask


     

lastListName = ''
lastListTag = 0
active = false
lastInput = 0
current_selected_list = 0

#triggered when user clicks on a list. Replaces the list with an inpult field to change the listname
updateList = (element, id) ->
	if(active == false) 
		listTag = element
		current_selected_list = id
		

		input = document.createElement('input')
		input.setAttribute('type','text')
		input.setAttribute('name','Listname')
		$(input).addClass("form-control")
		
		input.value = listTag.innerHTML
		listTag.appendChild(input)
	 
		#replace the List text with the form
		lastListName = listTag.innerHTML
		listTag.innerHTML = ''
		listTag.appendChild(input)
		 

		lastInput = input
		
		lastListTag = listTag
		input.focus()
		
		$(input).bind 'blur', =>
			listChanged()
		active = true
		
#triggered when the list inputfield lost focus. Saves the changes in the db
listChanged = () ->

	if(lastInput.value != lastListName)
		lastListName = lastInput.value;

		#ajax call to list update path
		$.ajax({
			type: "POST",
			data: { '_method':"PUT", 'list_name': lastListName},
			url: "/lists/"+current_selected_list,
		});


	lastInput.parentNode.removeChild(lastInput);
	lastListTag.innerHTML = lastListName;

	
	active = false;



window.updateList = updateList


### 
	DatePicker
###


datepicker = () ->
	$('.date').datepicker({
		todayBtn: true,
		language: "de",
		autoclose: true,
		todayHighlight: false,
		startDate: "+1d"
	});

$(document).ready () ->
  datepicker()
  
