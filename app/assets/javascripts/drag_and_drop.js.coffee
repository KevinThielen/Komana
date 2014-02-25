
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
	
	
	
window.dragstartEvent = dragstartEvent

#droptarget

#get all droptargets and give them the drag events 
ready = () ->
	$('.droptarget').bind 'dragenter', dragenterEvent
	$('.droptarget').bind 'dragleave', dragleaveEvent
	$('.droptarget').bind 'dragover', dragoverEvent
	$('.draggable').bind 'dragend', dragendEvent
	$('.droptarget').addClass('droptarget-default')
	

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
		$(e.originalEvent.target).addClass('droptarget-active')
		$(e.originalEvent.target).removeClass('droptarget-default')
	
	
window.dragenterEvent = dragenterEvent
	
	
dragleaveEvent = (e) ->
	e.originalEvent.stopPropagation()
	e.originalEvent.preventDefault()
	
	taskPositionClassname = getFullClassName(e.target, 'position')
	extractedTaskPosition = taskPositionClassname.substr 'position'.length
	
	taskListClassname = getFullClassName(e.target, 'list')
	extractedList = taskListClassname.substr 'list'.length
	
	if isOtherTask(extractedTaskPosition, extractedList)
		$(e.originalEvent.target).addClass('droptarget-default')
		$(e.originalEvent.target).removeClass('droptarget-active')
	
window.dragleaveEvent = dragleaveEvent


dragendEvent = (e) ->
	$('.droptarget').addClass('droptarget-default')
	$('.droptarget').removeClass('droptarget-active')

window.dragendEvent = dragendEvent

dropEvent = (e, position, list) ->
	if isOtherTask(position, list)  

		$(e.target).addClass('droptarget-default')
		$(e.target).removeClass('droptarget-active')
		
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
