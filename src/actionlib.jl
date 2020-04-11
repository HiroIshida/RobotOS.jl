using RobotOS
using PyCall

@rosimport control_msgs.msg: FollowJointTrajectoryAction, FollowJointTrajectoryGoal
@rosimport jsk_recognition_msgs.msg: PeoplePoseArray
rostypegen()
using .control_msgs.msg

init_node("test")


struct SimpleActionClient
    o::PyObject
    function SimpleActionClient(action_name, action_type)
        new(RobotOS.__actionlib__.SimpleActionClient(action_name, action_type))
    end
end

function wait_for_server(client::SimpleActionClient)
    client.o.wait_for_server
end
g = FollowJointTrajectoryGoal()


"""
name = "/head_traj_controller/follow_joint_trajectory"
client = SimpleActionClient(name, FollowJointTrajectoryAction)
client.o.wait_for_server()
"""
#FollowJointTrajectoryGoal

#goal = actionlib_tutorials.msg.FibonacciGoal(order=20)
#client.send_goal(goal)
#client.wait_for_result()


"""
# The joint trajectory to follow
trajectory_msgs/JointTrajectory trajectory

# Tolerances for the trajectory.  If the measured joint values fall
# outside the tolerances the trajectory goal is aborted.  Any
# tolerances that are not specified (by being omitted or set to 0) are
# set to the defaults for the action server (often taken from the
# parameter server).

# Tolerances applied to the joints as the trajectory is executed.  If
# violated, the goal aborts with error_code set to
# PATH_TOLERANCE_VIOLATED.
JointTolerance[] path_tolerance

# To report success, the joints must be within goal_tolerance of the
# final trajectory value.  The goal must be achieved by time the
# trajectory ends plus goal_time_tolerance.  (goal_time_tolerance
# allows some leeway in time, so that the trajectory goal can still
# succeed even if the joints reach the goal some time after the
# precise end time of the trajectory).
#
# If the joints are not within goal_tolerance after "trajectory finish
# time" + goal_time_tolerance, the goal aborts with error_code set to
# GOAL_TOLERANCE_VIOLATED
JointTolerance[] goal_tolerance
duration goal_time_tolerance

---
int32 error_code
int32 SUCCESSFUL = 0
int32 INVALID_GOAL = -1
int32 INVALID_JOINTS = -2
int32 OLD_HEADER_TIMESTAMP = -3
int32 PATH_TOLERANCE_VIOLATED = -4
int32 GOAL_TOLERANCE_VIOLATED = -5

# Human readable description of the error code. Contains complementary
# information that is especially useful when execution fails, for instance:
# - INVALID_GOAL: The reason for the invalid goal (e.g., the requested
#   trajectory is in the past).
# - INVALID_JOINTS: The mismatch between the expected controller joints
#   and those provided in the goal.
# - PATH_TOLERANCE_VIOLATED and GOAL_TOLERANCE_VIOLATED: Which joint
#   violated which tolerance, and by how much.
string error_string

---
Header header
string[] joint_names
trajectory_msgs/JointTrajectoryPoint desired
trajectory_msgs/JointTrajectoryPoint actual
trajectory_msgs/JointTrajectoryPoint error
"""
