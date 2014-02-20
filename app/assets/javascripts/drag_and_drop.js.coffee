
###
	Drag and Drop for Tasks in a List.
###



dragstartEvent = (event) ->
	alert('hshhs')
	
dragEvent = (event) ->
	alert('hshhs')
	
dragendEvent = (event) ->
	alert('hshhs')

	
window.dragstartEvent = dragstartEvent
window.dragEvent = dragEvent
window.dragendEvent = dragendEvent

###
drop_target = null
dragged_element = null


allow_drop = (event) ->
	event.preventDefault()

drag_enter = (event, position, list) ->
	event.preventDefault()
	
	if list isnt dragged_element.list or (position isnt dragged_element.position and position isnt dragged_element.position-1)
		if drop_target?
			reset_drag_target()
			
		drop_target = event.target
		drop_target.position = position
		drop_target.list = list
		
		$(event.target).css('background-color','blue')
		$(event.target).css('height','150px')

reset_drag_target = () ->
	$(drop_target).css('background-color','')
	$(drop_target).css('height','')
	drop_target = null


drag = (event, task, position, list) ->
	document.addEventListener "dragend", (->
		drop(event)
	), true
	
	
	console.log(event.target.id)
	dragged_element = event.target
	dragged_element.position = position
	dragged_element.list = list
	dragged_element.task_id = task
	
	
drop = (event) ->
	event.preventDefault()
	if drop_target?
		changed = true
		droptarget_element = $('.droptarget'+dragged_element.task_id)
		$(drop_target).before($(dragged_element))
		$(dragged_element).before(droptarget_element)
		
		
		#TODO: only on successfull ajax call
		#update the drag event for the dragged element
		$(dragged_element).attr('ondragstart', 'drag(event, '+dragged_element.task_id+', '+drop_target.position+', '+drop_target.list+')')
	
		#ajax call to update the task
		$.ajax({
			type: "POST",
			data: { '_method':"POST", 'list_id': drop_target.list, 'position': drop_target.position, 'old_position': dragged_element.position},
			url: "/tasks/"+dragged_element.task_id+"/update_position",
		});
		
	reset_drag_target()	

window.allow_drop = allow_drop
window.drag_enter = drag_enter
window.drag = drag
window.drop = drop
###
