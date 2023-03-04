using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AlertLightController : MonoBehaviour
{
    [SerializeField]
    public bool alert = false;

    [SerializeField]
    public float minSpotLightAngle = 50f;

    [SerializeField]
    public float maxSpotLightAngle = 130f;

    private Light alertLight;
    private float lightModifier = 0.25f;

    void Start()
    {
        alertLight = gameObject.GetComponent<Light>();
    }

    void Update()
    {
        if (alert) {
            if (alertLight.spotAngle >= maxSpotLightAngle)
                lightModifier = -0.25f;
            if (alertLight.spotAngle <= minSpotLightAngle)
                lightModifier = 0.25f;
            alertLight.spotAngle += lightModifier;
        }
    }

    public void ActivateLight()
    {
        alert = true;
    }
}
