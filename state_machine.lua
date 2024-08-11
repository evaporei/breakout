local StateMachine = {}

function StateMachine.new(states)
    local self = {}

    self.states = states

    setmetatable(self, { __index = StateMachine })
    return self
end

function StateMachine:change(params)
    local to = params[1]
    params.stateMachine = self
    self.curr = self.states[to](params)
end

function StateMachine:keypressed(key)
    self.curr:keypressed(key)
end

function StateMachine:update(dt)
    self.curr:update(dt)
end

function StateMachine:render()
    self.curr:render()
end

return StateMachine
