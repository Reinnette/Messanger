extends Node

var registerLock: Mutex
var sendLock: Mutex
var sendLockList = []

var msgList = {
	null: null
}

#Add the message and functions to a dictionary
func Register(msgName: int, toRun):
	registerLock.lock()
	
	if (!msgList.keys().has(msgName)):
		msgList[msgName] = []
	
	msgList[msgName].append(toRun)
	
	registerLock.unlock()
	
#Call each function for the given message
func Send(msgName: int, data = ""):
	var result = sendLock.try_lock()
	
	#There is a lock started
	#We need to check if its for this message name 
	#If there is already a lock on this key name wait till the lock is lifted
	#This is to help multithread performance by not locking the while dic
	if !result:
		while sendLockList.has(msgName): pass
	
	sendLockList.append(msgName)
	
	for message in msgList[msgName]:
		message.call()
		
	#We cannot simply remove the last item as more than one may have been added
	sendLockList.remove_at(sendLockList.find(msgName))
	
	sendLock.unlock()
