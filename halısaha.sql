ALTER TABLE Rezervasyon
ADD CONSTRAINT UQ_UserId_ContactID UNIQUE([Rezervasyon Tarihi], SaatID)