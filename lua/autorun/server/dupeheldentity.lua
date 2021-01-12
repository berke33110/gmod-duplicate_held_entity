concommand.Add("duplicate_held_entity", function(ply)
	for _, heldent in pairs(ents.GetAll()) do
		if heldent:IsPlayerHolding() then
			local copy = duplicator.Copy(heldent)
			local cEnts = duplicator.Paste(ply, copy.Entities, copy.Constraints)

			undo.Create("Duplicator")
			for _, ent in pairs(cEnts) do
				undo.AddEntity(ent)
				ply:AddCleanup("duplicates", ent)
				ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
				ent:CollisionRulesChanged()

				for physindex = 0, ent:GetPhysicsObjectCount() - 1 do
					local phys = ent:GetPhysicsObjectNum(physindex)
					if IsValid(phys) then phys:EnableMotion(false) end
				end
			end
			undo.SetPlayer(ply)
			undo.Finish()

			return
		end
	end
end)
