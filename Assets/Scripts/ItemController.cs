using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

public class ItemController : MonoBehaviour
{
    [SerializeField]
    private GameObject socketInteractor;

    [SerializeField]
    private XRGrabInteractable grabComponent;

    [SerializeField]
    private Collider collider;


    private bool _firstGrab = true;

    public void AutomaticallyPlaceOnBelt()
    {
        if (_firstGrab) {
            collider.enabled = false;
            grabComponent.enabled = false;
            transform.position = socketInteractor.transform.position;
            grabComponent.enabled = true;
            collider.enabled = true;
            _firstGrab = false;
        }
    }
}
