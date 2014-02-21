
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
	$('.draggable').bind 'dragend', dragendEvent
	$('.droptarget').css('background-color','')
	$('.droptarget').css('height','10px')

dragoverEvent = (e) ->
	e.preventDefault() 

window.dragoverEvent = dragoverEvent

dragenterEvent = (e) ->
	e.originalEvent.stopPropagation()
	e.originalEvent.preventDefault()

	taskPositionClassname = getFullClassName(e.target, 'position')
	extractedTaskPosition = taskPositionClassname.substr 'position'.length
	
	taskListClassname = getFullClassName(e.target, 'list')
	extractedList = taskListClassname.substr 'list'.length
	
	if isOtherTask(extractedTaskPosition, extractedList)
		$(e.originalEvent.target).css('background-color','yellow')
		$(e.originalEvent.target).css('height','150px')
	
	
window.dragenterEvent = dragenterEvent
	
	
dragleaveEvent = (e) ->
	e.originalEvent.stopPropagation()
	e.originalEvent.preventDefault()
	
	taskPositionClassname = getFullClassName(e.target, 'position')
	extractedTaskPosition = taskPositionClassname.substr 'position'.length
	
	taskListClassname = getFullClassName(e.target, 'list')
	extractedList = taskListClassname.substr 'list'.length
	
	if isOtherTask(extractedTaskPosition, extractedList)
		$(e.originalEvent.target).css('background-color','')
		$(e.originalEvent.target).css('height','10px')
	
window.dragleaveEvent = dragleaveEvent


dragendEvent = (e) ->
	$('.droptarget').css('background-color','')
	$('.droptarget').css('height','10px')

window.dragendEvent = dragendEvent

dropEvent = (e, position, list) ->
	if isOtherTask(position, list)  
		console.log("target: Position: "+position+", List: "+list)
		$(e.target).css('background-color','blue')
		
		#ajax call to update the task
		$.ajax({
			type: "POST",
			data: { '_method':"POST", 'list_id': list, 'position': position, 'old_position': dragged_task.position},
			url: "/tasks/"+dragged_task.id+"/update_position",
		});
				
					
		old_previous_tasks = $(dragged_task).prevAll('.draggable')
		
		$(e.target).before($('.task'+dragged_task.id))
		
		#change the old list class to the new one
		$('.task'+dragged_task.id).removeClass('list'+dragged_task.list)
		$('.task'+dragged_task.id).addClass('list'+list)
			
		$(dragged_task).removeClass 'position'+dragged_task.position
		if (list is dragged_task.list and position < dragged_task.position) || list isnt dragged_task.list
			++position
			
		$(dragged_task).addClass 'position'+position
		#change their dragstart function to the updated values
		$(dragged_task).removeAttr("ondragstart").unbind("dragstart");
		$(dragged_task).bind 'dragstart', ->
			dragstartEvent(event, dragged_task.id, position, list)
       
		#change the drop function for the droptarget
		$(dragged_task).prev('.droptarget').removeAttr("ondrop").unbind("drop");
		$(dragged_task).prev('.droptarget').bind 'drop', ->
			dropEvent(event, position, list)
				
		
		#iterate over the new tasks in the list previously to this task and increase their position by 1
		previous_tasks = $(dragged_task).prevAll('.draggable')
		previous_tasks.each ->
			taskPositionClassname = getFullClassName(this, 'position')
			extractedTaskPosition = taskPositionClassname.substr 'position'.length
			$(this).removeClass taskPositionClassname
			extractedTaskPosition++
			$(this).addClass 'position'+extractedTaskPosition
			
			taskIdClassname = getFullClassName(this, 'task')
			extractedTaskId = taskIdClassname.substr 'task'.length
			
			#change their dragstart function to the updated values
			$(this).removeAttr("ondragstart").unbind("dragstart");
			$(this).bind 'dragstart', ->
				dragstartEvent(event, extractedTaskId, extractedTaskPosition, list)
       
			#change the drop function for the droptarget
			$(this).prev('.droptarget').removeAttr("ondrop").unbind("drop");
			$(this).prev('.droptarget').bind 'drop', ->
				dropEvent(event, extractedTaskPosition, list)
			
		#decrease the position/function param for all previous tasks in the previous list
		old_previous_tasks.each ->
			taskPositionClassname = getFullClassName(this, 'position')
			extractedTaskPosition = taskPositionClassname.substr 'position'.length
			$(this).removeClass taskPositionClassname
			extractedTaskPosition--
			$(this).addClass 'position'+extractedTaskPosition
			
			taskIdClassname = getFullClassName(this, 'task')
			extractedTaskId = taskIdClassname.substr 'task'.length
			
			#change their dragstart function to the updated values
			$(this).removeAttr("ondragstart").unbind("dragstart");
			$(this).bind 'dragstart', ->
				dragstartEvent(event, extractedTaskId, extractedTaskPosition, dragged_task.list)
       
			#change the drop function for the droptarget
			$(this).prev('.droptarget').removeAttr("ondrop").unbind("drop");
			$(this).prev('.droptarget').bind 'drop', ->
				dropEvent(event, extractedTaskPosition, dragged_task.list)

# checks if the passed position isnt adjacent to the dragged task		
isOtherTask = (position, list) ->
	return list isnt dragged_task.list or (position isnt dragged_task.position and parseInt(position)+1 isnt parseInt(dragged_task.position)) 
		
window.dropEvent = dropEvent

	  
$(document).ready(ready)
$(document).on('page:load', ready) 


#iterates over all classes of el and returns the full classname that starts with class
getFullClassName = (el, myclass) ->
	classNames = $(el).attr('class').split(/\s+/);  

	for value in classNames
		if value.indexOf(myclass) is 0
			return value			
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
