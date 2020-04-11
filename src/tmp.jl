using PyCall
_controlmsg_ = PyCall.PyNULL()
_trajmsg_ = PyCall.PyNULL()

copy!(_controlmsg_, pyimport("control_msgs.msg"))
copy!(_trajmsg_, pyimport("trajectory_msgs.msg"))

goal = _controlmsg_.FollowJointTrajectoryGoal

using Revise
using RobotOS
@rosimport control_msgs.msg: FollowJointTrajectoryGoal

### rostypegen
pkgdps = RobotOS._collectdeps(RobotOS._rospy_imports)
pkglst = RobotOS._order(pkgdps)

for i in 1:3
    code = RobotOS.buildpackage(RobotOS._rospy_imports[pkglst[i]], Main)
end
codes = [RobotOS.buildpackage_debug(RobotOS._rospy_imports[pkglst[i]], Main) for i in 1:3]

for i in 1:3
    code = codes[i]
    name = "dump_" * string(i) *".txt"
    open(name, "w" ) do fp
      write( fp, repr(code))
    end
end


import .trajectory_msgs.msg: JointTrajectory 
import .control_msgs.msg: FollowJointTrajectoryGoal, JointTolerance

println(JointTrajectory <: RobotOS.AbstractMsg)
println(FollowJointTrajectoryGoal <: RobotOS.AbstractMsg)

JointTolerance()



#code = RobotOS.buildpackage_debug(RobotOS._rospy_imports[pkglst[1]], Main)



