SET GLOBAL event_scheduler = ON;
SET @@GLOBAL.event_scheduler = ON;
SET GLOBAL event_scheduler = 1;
SET @@GLOBAL.event_scheduler = 1;
CREATE 
    DEFINER = `root`@`localhost` 
EVENT Invitation_Checker
ON SCHEDULE EVERY 30 MINUTE
DO
    DELETE LOW_PRIORITY FROM Jarvis.Inviter
    WHERE (Jarvis.Inviter.validiter='invalide') 
    OR
    (timestampdiff(MINUTE,Jarvis.Inviter.`date_ajout_invitation`,current_timestamp())>120)