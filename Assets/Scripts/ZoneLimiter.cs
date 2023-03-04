using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoneLimiter : MonoBehaviour
{
    [SerializeField]
    private AudioManager audioManager;

    [SerializeField]
    private int zoneLimit = 0;

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
            CheckAcces();
    }

    private void CheckAcces()
    {
        switch (zoneLimit) {
            case 1: audioManager.PlayEnterCaveDenied(); break;
            case 2: audioManager.PlayEnterLastZoneDenied(); break;
        }
    }
}
