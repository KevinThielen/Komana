
###
	Drag and Drop for Tasks
###


#dragable

dragged_task = null

dragstartEvent = (e, id, position, list) ->
	dragged_task = e.target
	dragged_task.id = id
	dragged_task.position = position
	dragged_task.list = list
	
	console.log("Task: "+dragged_task.id+", Position: "+dragged_task.position+", List: "+dragged_task.list)
	
window.dragstartEvent = dragstartEvent

#droptarget

#get all droptargets and give them the drag events 
ready = () ->
	$('.droptarget').bind 'dragenter', dragenterEvent
	$('.droptarget').bind 'dragleave', dragleaveEvent
	$('.droptarget').bind 'dragover', dragoverEvent


dragoverEvent = (e) ->
	e.preventDefault() 

window.dragoverEvent = dragoverEvent

dragenterEvent = (e) ->
	e.originalEvent.stopPropagation()
	e.originalEvent.preventDefault()
	$(e.originalEvent.target).css('background-color','yellow')

window.dragenterEvent = dragenterEvent
	
	
dragleaveEvent = (e) ->
	e.originalEvent.stopPropagation()
	e.originalEvent.preventDefault()
	$(e.originalEvent.target).css('background-color','blue')
	
window.dragleaveEvent = dragleaveEvent

dropEvent = (e, position, list) ->
	if isOtherTask(position, list)  
		console.log("target: Position: "+position+", List: "+list)
		$(e.target).css('background-color','blue')
		
		$(e.target).before($('.task'+dragged_task.id))
		
		#increase the position of all previous tasks
		
		i = 0
		previous_tasks = $(dragged_task).prevAll('.draggable')
		previous_tasks.each ->
			extractedtaskId = this.
			console.log(task)
			
		

isOtherTask = (position, list) ->
	return list isnt dragged_task.list or (position isnt dragged_task.position and position-1 isnt dragged_task.position) 
		
window.dropEvent = dropEvent

	  
$(document).ready(ready)
$(document).on('page:load', ready) 

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
