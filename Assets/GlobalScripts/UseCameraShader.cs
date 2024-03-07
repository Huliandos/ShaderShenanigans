using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class UseCameraShader : MonoBehaviour
{
    [SerializeField]
    Material _camerMat;

    void OnRenderImage(RenderTexture source, RenderTexture destination) { 
        Graphics.Blit(source, destination, _camerMat);
    }
}
