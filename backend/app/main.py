from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from pydantic import BaseModel
from typing import List

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

class Estacion(BaseModel):
    id: int
    nombre: str
    ubicacion: str

db_estaciones = [
    {"id": 1, "nombre": "Estación Norte", "ubicacion": "Norte"},
    {"id": 2, "nombre": "Estación Sur", "ubicacion": "Sur"}
]

@app.get("/")
def read_root():
    return {"message": "Servidor SMAT Activo"}

@app.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    if form_data.username == "jordybujaicob-netizen" and form_data.password == "jordybujaicob-netizen":
        return {"access_token": "token-secreto-abc", "token_type": "bearer"}
    raise HTTPException(status_code=400, detail="Usuario o contraseña incorrectos")

@app.get("/estaciones/", response_model=List[Estacion])
async def get_estaciones(token: str = Depends(oauth2_scheme)):
    return db_estaciones

@app.post("/estaciones/", status_code=201)
async def create_estacion(estacion: Estacion, token: str = Depends(oauth2_scheme)):
    db_estaciones.append(estacion.dict())
    return {"message": "Estación creada"}