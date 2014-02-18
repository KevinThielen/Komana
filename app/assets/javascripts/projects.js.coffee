# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
	Updates the Task on the project view. 
	It will open the modal and pass the calling Task
	params to the form.
###



updateTask = (id, titel, text, user) ->
	taskTitel = document.getElementById('task_titel')
	taskTitel.value = titel
	taskText = document.getElementById('task_text')
	taskText.value = text
	taskId = document.getElementById('task_id')
	taskId.value = id
	
    # dropdown menu default value
	assigned_user = document.getElementById('user_id')
	i = 0
	while i < assigned_user.options.length
		assigned_user.options[i].selected = true  if assigned_user.options[i].value is user
		i++

	$('#editTaskModal').modal('show')
    
window.updateTask = updateTask


     

###
	Updates the List on the project view. 
	It will create an input form and calls the list update
	controller method to save the changes when leaving focus.
###


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
	Toogle the list
###

toggleList = (list, list_class) ->

	if $(list).hasClass('hidden_list') == false
		$("."+list_class).slideUp();
		$(list).addClass('hidden_list')
		
		#SHOW 
		list.innerHTML = '<i class="fa fa-chevron-right"></i>'
	else
		$("."+list_class).slideDown();
		
		#HIDE 
		list.innerHTML = '<i class="fa fa-chevron-down"></i>'
		$(list).removeClass('hidden_list')

window.toggleList = toggleList
